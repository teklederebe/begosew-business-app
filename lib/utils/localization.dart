import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const _localizedValues = {
    'en': {
      'login': 'Login',
      'dashboard': 'Dashboard',
      'admin_panel': 'Admin Panel',
      'welcome': 'Welcome to Begosew Cement & Rebar',
    },
    'am': {
      'login': 'መግቢያ',
      'dashboard': 'ዳሽቦርድ',
      'admin_panel': 'የአስተዳደር ፓነል',
      'welcome': 'እንኳን ደህና መጡ በቤጎሰው ሲሚንት እና ቅርጽ ብረት',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'am'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
