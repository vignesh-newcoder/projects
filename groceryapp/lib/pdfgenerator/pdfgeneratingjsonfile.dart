import 'dart:convert';
class Pdfgeneratingpdf {
  static String pdfvalue(
    String deliveryShopName,
    String deliveryPhone,
    List items,
    num totalAmount,
    DateTime orderDate,
  ) {
    final data = {
      "GSTIN": "",
      "Cell": "9042225551",
      "GlobalShopName": "JBM TRADERS",
      "DeliveryName": deliveryShopName,
      "DeliveryPhone": deliveryPhone,
      "Items": items,
      "TotalAmount": totalAmount,
      "DateTime": orderDate.toIso8601String(),
    };
    return jsonEncode(data);
  }
}
