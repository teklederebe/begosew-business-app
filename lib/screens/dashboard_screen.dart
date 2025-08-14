import 'package:flutter/material.dart';
import '../utils/localization.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('dashboard'))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.translate('dashboard'),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('📈 Analytics coming soon...'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin');
              },
              child: Text(loc.translate('admin_panel')),
            ),
          ],
        ),
      ),
    );
  }
}
