import 'package:card_application/database/db_helper.dart';
import 'package:card_application/states/card_transactions.dart';
import 'package:card_application/states/dashboard_provider.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/localization_manager.dart';
import 'package:card_application/views/mainscreens/dashboard.dart';
import 'package:card_application/views/mainscreens/login_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isPass = false;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black87, // navigation bar color
    statusBarColor: Colors.black, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await _init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashProvider()),
        ChangeNotifierProvider(
          create: (_) => CardTransactionsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DbHelper(),
        ),
      ],
      child: EasyLocalization(
          supportedLocales: LocalizationManager.instance.supportedLocales,
          fallbackLocale: LocalizationManager.instance.trLocale,
          path: 'assets/translations',
          child: const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myprovider = Provider.of<DashProvider>(context, listen: true);
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: myprovider.locale,
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
      home: isPass ? WADashboardScreen() : LoginScreen(),
    );
  }
}

_init() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isPass = prefs.getBool('passlogin');
    print("isPass" + isPass.toString());
    if (isPass == null) {
      isPass = false;
    }
  } catch (e) {
    print(e);
  }
}
