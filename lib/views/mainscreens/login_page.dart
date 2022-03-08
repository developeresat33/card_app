import 'package:card_application/utils/box_constraints.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/views/mainscreens/dashboard.dart';
import 'package:card_application/widgets/dialogs/common_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_application/extensions/string_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String tag = '/LoginScreen';

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          CommonDialogs.callLogout();
          return;
        },
        child: Scaffold(
          body: Container(
            width: context.width,
            height: context.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover)),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  50.height,
                  Container(
                    margin: EdgeInsets.all(16),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Container(
                          width: context.width,
                          padding:
                              EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          margin: EdgeInsets.only(top: 55.0),
                          decoration: boxDecorationWithShadow(
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      80.height,
                                      Text(
                                        "Bu uygulama'da hesap işlemleri bulunmamaktadır.\nVerileriniz telefonunuzun hafızasına kaydedilecektir.\nYedekleme işlemleri için seçeneklerimiz bulunmaktadır.",
                                        textAlign: TextAlign.center,
                                      ),
                                      30.height,
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: MaterialButton(
                                              onPressed: () async {
                                                await _saveOptions();
                                                await Get.to(
                                                    () => WADashboardScreen());
                                              },
                                              child: Text(
                                                  "login.login".translate()),
                                              color: WAPrimaryColor,
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          )
                                        ],
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: 100,
                          decoration: boxDecorationRoundedWithShadow(30),
                          child: Image.asset(
                            'assets/wa_app_logo.png',
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),
                  16.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _saveOptions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('passlogin', true);
    } on Exception catch (e) {
      print(e);
    }
  }
}
