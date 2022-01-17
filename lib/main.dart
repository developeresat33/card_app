import 'package:card_application/mainscreens/login_page.dart';
import 'package:card_application/states/dashboard_provider.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/localization_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashProvider()),
      ],
      child: EasyLocalization(
          supportedLocales: LocalizationManager.instance.supportedLocales,
          fallbackLocale: LocalizationManager.instance.trLocale,
          path: 'assets/translations',
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Card_App_Demo',
      theme: ThemeData(
          primarySwatch: Colors.red,
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: WAPrimaryColor, secondary: Colors.black54),
          fontFamily: "Raleway",
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 16.0,
            ),
            headline6: TextStyle(
              fontSize: 16.0,
            ),
            bodyText1: TextStyle(fontSize: 14.0),
            bodyText2: TextStyle(fontSize: 14.0),
            button: TextStyle(fontSize: 15.0),
          ),
          primaryIconTheme: IconThemeData(color: WAPrimaryColor),
          primaryColor: WAPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          checkboxTheme: CheckboxThemeData(
              fillColor: MaterialStateProperty.all(WAPrimaryColor))),
      home: LoginScreen(),
    );
  }
}
