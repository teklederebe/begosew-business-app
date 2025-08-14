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

  List<Map<String, dynamic>> items = [];

  void addItem() {
    setState(() {
      items.add({'name': '', 'qty': 1, 'price': 0});
    });
  }

  void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

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
              Text('🧱 Items', style: TextStyle(fontWeight: FontWeight.bold)),
              ...items.asMap().entries.map((entry) {
                int index = entry.key;
                var item = entry.value;
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: item['name'],
                          decoration: InputDecoration(labelText: 'Item Name'),
                          onChanged: (val) => item['name'] = val,
                        ),
                        TextFormField(
                          initialValue: item['qty'].toString(),
                          decoration: InputDecoration(labelText: 'Quantity'),
                          keyboardType: TextInputType.number,
                          onChanged: (val) => item['qty'] = int.tryParse(val) ?? 1,
                        ),
                        TextFormField(
                          initialValue: item['price'].toString(),
                          decoration: InputDecoration(labelText: 'Price'),
                          keyboardType: TextInputType.number,
                          onChanged: (val) => item['price'] = int.tryParse(val) ?? 0,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeItem(index),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              ElevatedButton(
                onPressed: addItem,
                child: Text('➕ Add Item'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && items.isNotEmpty) {
                    final file = await generateInvoice(
                      customerName: _customerController.text,
                      vendorName: _vendorController.text,
                      invoiceNumber: _invoiceController.text,
                      date: DateTime.now(),
                      items: items,
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
