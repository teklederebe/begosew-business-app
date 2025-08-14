import 'package:flutter/material.dart';
import '../utils/localization.dart';
import '../utils/pdf_invoice.dart';

class AdminPanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('admin_panel'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.translate('admin_panel'),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('🧑‍💼 Vendor & Customer Management coming soon...'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: Text(loc.translate('dashboard')),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final file = await generateInvoice(
                  customerName: 'Abebe Kebede',
                  vendorName: 'Begosew Cement',
                  invoiceNumber: 'INV-001',
                  date: DateTime.now(),
                  items: [
                    {'name': 'Cement', 'qty': 10, 'price': 400},
                    {'name': 'Rebar', 'qty': 5, 'price': 600},
                  ],
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Invoice generated: ${file.path}')),
                );
              },
              child: Text('🧾 Generate Invoice'),
            ),
          ],
        ),
      ),
    );
  }
}
