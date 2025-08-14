import 'package:flutter/material.dart';
import '../utils/localization.dart';
import '../utils/pdf_invoice.dart';

class AdminPanelScreen extends StatefulWidget {
  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerController = TextEditingController();
  final _vendorController = TextEditingController();
  final _invoiceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('admin_panel'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                loc.translate('admin_panel'),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _customerController,
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _vendorController,
                decoration: InputDecoration(labelText: 'Vendor Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _invoiceController,
                decoration: InputDecoration(labelText: 'Invoice Number'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final file = await generateInvoice(
                      customerName: _customerController.text,
                      vendorName: _vendorController.text,
                      invoiceNumber: _invoiceController.text,
                      date: DateTime.now(),
                      items: [
                        {'name': 'Cement', 'qty': 10, 'price': 400},
                      ],
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invoice generated: ${file.path}')),
                    );
                  }
                },
                child: Text('🧾 Generate Invoice'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
                child: Text(loc.translate('dashboard')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
