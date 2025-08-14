import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/admin_panel_screen.dart';
import 'utils/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BegosewApp());
}

class BegosewApp extends StatefulWidget {
  @override
  _BegosewAppState createState() => _BegosewAppState();
}

class _BegosewAppState extends State<BegosewApp> {
  Locale _locale = Locale('en');

  void setLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Begosew Cement & Rebar',
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('am')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/admin': (context) => AdminPanelScreen(),
      },
    );
  }
}
