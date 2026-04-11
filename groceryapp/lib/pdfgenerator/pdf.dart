// lib/pdfgenerator/pdf.dart

import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> _buildPdf(Map<String, dynamic> p) async {
  // ── safe param reads ──────────────────────────────────────────────────────
  final String shopName = (p['shopName'] ?? 'N/A').toString();
  final String phone = (p['phone'] ?? 'N/A').toString();
  final String dateStr = (p['dateStr'] ?? '').toString();
  final num totalAmount = (p['totalAmount'] as num?) ?? 0;
  final List rawItems = (p['items'] as List?) ?? [];

  // ── sanitise items ────────────────────────────────────────────────────────
  final items = rawItems.map((e) {
    final m = ((e as Map?)?.cast<String, dynamic>()) ?? <String, dynamic>{};
    return <String, dynamic>{
      'name': (m['name'] ?? '').toString(),
      'qty': (m['qty'] is num) ? (m['qty'] as num).toInt() : 0,
      'price': (m['price'] is num) ? (m['price'] as num).toDouble() : 0.0,
    };
  }).toList();

  // ── rounded total ─────────────────────────────────────────────────────────
  final double roundedTotal = double.parse(totalAmount.toStringAsFixed(2));

  // ── cell builder ──────────────────────────────────────────────────────────
  pw.Widget _cell(String text,
      {bool bold = false, bool right = false, bool center = false, double size = 9.5}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      child: pw.Align(
        alignment: right
            ? pw.Alignment.centerRight
            : center
                ? pw.Alignment.center
                : pw.Alignment.centerLeft,
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: size,
            fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // ── column widths ─────────────────────────────────────────────────────────
  const colWidths = <int, pw.TableColumnWidth>{
    0: pw.FlexColumnWidth(0.55), // S.No
    1: pw.FlexColumnWidth(3.4), // Particulars
    2: pw.FlexColumnWidth(0.85), // Qty
    3: pw.FlexColumnWidth(1.5), // Rate
    4: pw.FlexColumnWidth(1.5), // Amount
  };

  // ── header row ────────────────────────────────────────────────────────────
  pw.TableRow _headerRow() => pw.TableRow(
        decoration: const pw.BoxDecoration(color: PdfColors.grey300),
        children: [
          _cell('S.No', bold: true, center: true),
          _cell('Particulars', bold: true),
          _cell('Qty', bold: true, right: true),
          _cell('Rate', bold: true, right: true),
          _cell('Amount', bold: true, right: true),
        ],
      );

  // ── item rows ─────────────────────────────────────────────────────────────
  final rows = <pw.TableRow>[_headerRow()];
  for (int i = 0; i < items.length; i++) {
    final name = items[i]['name'] as String;
    final qty = items[i]['qty'] as int;
    final rate = items[i]['price'] as double;
    final amount = qty * rate;
    rows.add(pw.TableRow(
      decoration: pw.BoxDecoration(color: i.isEven ? PdfColors.white : PdfColors.grey100),
      children: [
        _cell('${i + 1}', center: true),
        _cell(name),
        _cell('$qty', right: true),
        _cell('Rs.${rate.toStringAsFixed(2)}', right: true),
        _cell('Rs.${amount.toStringAsFixed(2)}', right: true),
      ],
    ));
  }

  // ── invoice header (first page only, via header: param) ──────────────────
  pw.Widget _invoiceHeader() => pw.Padding(
        // inner padding so content sits away from the outer border
        padding: const pw.EdgeInsets.fromLTRB(14, 12, 14, 0),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // GSTIN  |  Phone
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('GSTIN: XXXXXXXXXXXXXX', style: const pw.TextStyle(fontSize: 9)),
                pw.Text('Cell: 9042225551', style: const pw.TextStyle(fontSize: 9)),
              ],
            ),

            pw.SizedBox(height: 8),

            // Company name — centred, bold, larger
            pw.Center(
              child: pw.Text(
                'JBM TRADERS',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),

            pw.SizedBox(height: 3),

            // Sub-title
            pw.Center(
              child: pw.Text(
                'TAX INVOICE',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey700,
                  letterSpacing: 1.5,
                ),
              ),
            ),

            pw.SizedBox(height: 10),

            // Thin divider under title
            pw.Divider(thickness: 0.6, color: PdfColors.grey500),

            pw.SizedBox(height: 6),

            // Store No | Date
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Store No : 539', style: const pw.TextStyle(fontSize: 9)),
                pw.Text('Date : $dateStr', style: const pw.TextStyle(fontSize: 9)),
              ],
            ),

            pw.SizedBox(height: 5),

            // Delivery info
            pw.Row(
              children: [
                pw.Text('Delivered To : ',
                    style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                pw.Text(shopName, style: const pw.TextStyle(fontSize: 9)),
              ],
            ),
            pw.SizedBox(height: 3),
            pw.Row(
              children: [
                pw.Text('Phone        : ',
                    style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                pw.Text(phone, style: const pw.TextStyle(fontSize: 9)),
              ],
            ),

            pw.SizedBox(height: 10),

            // Divider before table
            pw.Divider(thickness: 0.6, color: PdfColors.grey500),

            pw.SizedBox(height: 6),
          ],
        ),
      );

  // ── page theme — comfortable margin from edge ─────────────────────────────
  final pageTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    // outer margin gives breathing room between paper edge & content
    margin: const pw.EdgeInsets.all(32),
    buildBackground: (ctx) => pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 1.2),
      ),
    ),
  );

  // ── document ──────────────────────────────────────────────────────────────
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      header: (ctx) => ctx.pageNumber == 1 ? _invoiceHeader() : pw.SizedBox(height: 8),
      footer: (ctx) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 6, right: 14, bottom: 4),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('JBM TRADERS — Confidential',
                style: pw.TextStyle(fontSize: 7.5, color: PdfColors.grey500)),
            pw.Text('Page ${ctx.pageNumber} of ${ctx.pagesCount}',
                style: pw.TextStyle(fontSize: 7.5, color: PdfColors.grey600)),
          ],
        ),
      ),
      build: (ctx) => [
        // ── inner padding so table never touches the border ───────────────
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 14),
          child: pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey600, width: 0.5),
            columnWidths: colWidths,
            children: rows,
          ),
        ),

        pw.SizedBox(height: 14),

        // ── total — compact, right-aligned, same font size as table ──────
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 14),
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey200,
                border: pw.Border.all(color: PdfColors.grey600, width: 0.5),
              ),
              child: pw.Row(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Text(
                    'Total Amount :  ',
                    style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    'Rs. ${roundedTotal.toStringAsFixed(2)}',
                    style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),

        pw.SizedBox(height: 28),

        // ── thank-you note ────────────────────────────────────────────────
        pw.Center(
          child: pw.Text(
            '- Thank You!  Visit Again -',
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.grey700,
              letterSpacing: 0.8,
            ),
          ),
        ),

        pw.SizedBox(height: 16),
      ],
    ),
  );

  return Uint8List.fromList(await pdf.save());
}

// ─────────────────────────────────────────────────────────────────────────────
class GeneratePdf {
  static Future<void> generateInvoicePdf({
    required String deliveryShopName,
    required String deliveryPhone,
    required List items,
    required num totalAmount,
    required DateTime orderDate,
  }) async {
    final dateStr = '${orderDate.day.toString().padLeft(2, '0')}/'
        '${orderDate.month.toString().padLeft(2, '0')}/'
        '${orderDate.year}';

    final params = <String, dynamic>{
      'shopName': deliveryShopName,
      'phone': deliveryPhone,
      'items': List<Map<String, dynamic>>.from(items),
      'totalAmount': totalAmount,
      'dateStr': dateStr,
    };

    final Uint8List bytes = await compute(_buildPdf, params);

    await Printing.layoutPdf(
      name: 'Invoice_${deliveryShopName}_$dateStr',
      onLayout: (_) async => bytes,
    );
  }
}
