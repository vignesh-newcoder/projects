import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GeneratePdf {
  static Future<void> generateInvoicePdf(
    String deliveryShopName,
    String deliveryPhone,
    List items,
    num totalAmount,
    DateTime orderDate,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        /// 🔹 Page Theme (Border + Margin)
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,

          /// Outer space from page edge
          margin: const pw.EdgeInsets.all(30),

          /// Border on every page
          buildBackground: (context) => pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: PdfColors.black,
                width: 1.5,
              ),
            ),
          ),
        ),

        build: (pw.Context context) => [
          /// 🔹 Inner Padding (space between border and content)
          pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                /// GST + Cell
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "GSTIN: XXXXXXXXXXXXXX",
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                    pw.Text(
                      "Cell: 9042225551",
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ],
                ),

                pw.SizedBox(height: 10),

                /// Store Name
                pw.Center(
                  child: pw.Text(
                    "JBM TRADERS",
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                pw.SizedBox(height: 20),

                /// Store No + Date
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Store No: 539"),
                    pw.Text(
                      "Date: ${orderDate.day}/${orderDate.month}/${orderDate.year}",
                    ),
                  ],
                ),

                pw.SizedBox(height: 12),

                /// Delivery Details
                pw.Text("Delivered To: $deliveryShopName"),
                pw.Text("Phone: $deliveryPhone"),

                pw.SizedBox(height: 20),

                pw.Divider(),

                pw.SizedBox(height: 15),

                /// 🔹 Table (Auto Page Break)
                pw.Table.fromTextArray(
                  border: pw.TableBorder.all(),
                  headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                  headers: [
                    "Particulars",
                    "Qty",
                    "Rate",
                    "Amount",
                  ],
                  data: items.map((item) {
                    final qty = item['qty'];
                    final rate = item['price'];
                    final amount = qty * rate;

                    return [
                      item['name'].toString(),
                      qty.toString(),
                      rate.toString(),
                      amount.toString(),
                    ];
                  }).toList(),
                ),

                pw.SizedBox(height: 25),

                /// Total
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    "Total: Rupees $totalAmount",
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                pw.SizedBox(height: 30),

                pw.Center(
                  child: pw.Text(
                    "Thank You! Visit Again",
                    style: const pw.TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
