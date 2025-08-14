import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

Future<File> generateInvoice({
  required String customerName,
  required String vendorName,
  required List<Map<String, dynamic>> items,
  required String invoiceNumber,
  required DateTime date,
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('የቲኬት መረጃ / Invoice Details',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text('ደንበኛ / Customer: $customerName'),
            pw.Text('አቅራቢ / Vendor: $vendorName'),
            pw.Text('ቁጥር / Invoice #: $invoiceNumber'),
            pw.Text('ቀን / Date: ${date.toLocal().toString().split(' ')[0]}'),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              headers: ['Item / እቃ', 'Qty / ብዛት', 'Price / ዋጋ', 'Total / ድምር'],
              data: items.map((item) {
                final total = item['qty'] * item['price'];
                return [
                  item['name'],
                  item['qty'].toString(),
                  item['price'].toString(),
                  total.toString()
                ];
              }).toList(),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'አጠቃላይ / Grand Total: ${items.fold(0, (sum, item) => sum + item['qty'] * item['price'])}',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
          ],
        );
      },
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/invoice_$invoiceNumber.pdf");
  await file.writeAsBytes(await pdf.save());
  return file;
}
