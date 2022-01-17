// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en_US = {
  "home": {
    "hi": "Hi",
    "cards": "Cards",
    "add_card": "Add Card",
    "limit": "Limit",
    "op": "Operators",
    "point": "Points",
    "shop": "Shopping",
    "ticket": "Tickets",
    "budget": "Budgets",
    "transc": "Transactions",
    "tod": "Today"
  },
  "login": {
    "log_in": "Log In",
    "id": "ID",
    "pw": "Password",
    "forgot": "Forgot Password?",
    "login": "Continue",
    "register": "Register"
  },
  "statistics": {
    "sta": "Statistics",
    "inc": "Income",
    "sp": "Spent",
    "rw": "Rewards",
    "all": "All",
    "mon": "Monthly",
    "year": "Yearly",
    "dy": "Daily",
    "wk": "Weekly",
    "mn": "Mon",
    "ts": "Tue",
    "ws": "Wed",
    "trs": "Thu",
    "fr": "Fri",
    "str": "Sat",
    "sun": "Sun",
    "cat": "Categories",
    "cat_titles": {
      "clt": "Clothes",
      "shp": "Shopping"
    }
  }
};
static const Map<String,dynamic> tr_TR = {
  "home": {
    "hi": "Merhaba",
    "cards": "Kartlar",
    "add_card": "Kart Ekle",
    "limit": "Limit",
    "op": "Operatörler",
    "point": "Puanlar",
    "shop": "Alışveriş",
    "ticket": "Biletler",
    "budget": "Bütçeler",
    "transc": "İşlemler",
    "tod": "Bugün"
  },
  "login": {
    "log_in": "Giriş",
    "id": "Kullanıcı Adı",
    "pw": "Şifre",
    "forgot": "Şifremi unuttum?",
    "login": "Giriş Yap",
    "register": "Kayıt Ol"
  },
  "statistics": {
    "sta": "İstatistkiler",
    "inc": "Gelir",
    "sp": "Harcanan",
    "rw": "Genel Bakış",
    "all": "Hepsi",
    "mon": "Aylık",
    "year": "Yıllık",
    "dy": "Günlük",
    "wk": "Haftalık",
    "mn": "Pzt",
    "ts": "Sal",
    "ws": "Çar",
    "trs": "Per",
    "fr": "Cum",
    "str": "Cmt",
    "sun": "Pzr",
    "cat": "Kategoriler",
    "cat_titles": {
      "clt": "Giyim",
      "shp": "Market"
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": en_US, "tr_TR": tr_TR};
}
