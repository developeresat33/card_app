import 'package:card_application/extensions/content_extensions.dart';
import 'package:card_application/extensions/int_extensions.dart';
import 'package:card_application/widgets/custom_button.dart';
import 'package:card_application/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

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
      child: Scaffold(
        body: Container(
          width: context.width(),
          height: context.height(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                50.height,
                Text("Giriş", style: TextStyle(fontSize: 24)),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(
                        width: context.width(),
                        padding:
                            EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        margin: EdgeInsets.only(top: 55.0),
                        decoration: boxDecorationWithShadow(
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    60.height,
                                    CustomTextFormField(
                                      placeholder: "Kullanıcı Adı",
                                    ),
                                    16.height,
                                    CustomTextFormField(
                                      placeholder: "Şifre",
                                    ),
                                    16.height,
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("Şifremi Unuttum?",
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                    30.height,
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: MaterialButton(
                                            onPressed: () {},
                                            child: Text("Giriş Yap"),
                                            color:
                                                Color.fromRGBO(50, 205, 50, 1),
                                            textColor: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        )
                                      ],
                                    ),
                                    20.height
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
    );
  }
}

Decoration boxDecorationWithShadow({
  Color backgroundColor = Colors.white,
  Color shadowColor,
  double blurRadius,
  double spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
  LinearGradient gradient,
  BoxBorder border,
  List<BoxShadow> boxShadow,
  DecorationImage decorationImage,
  BoxShape boxShape = BoxShape.rectangle,
  BorderRadius borderRadius,
}) {
  return BoxDecoration(
    boxShadow: boxShadow ??
        defaultBoxShadow(
          shadowColor: shadowColor,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
          offset: offset,
        ),
    color: backgroundColor,
    gradient: gradient,
    border: border,
    image: decorationImage,
    shape: boxShape,
    borderRadius: borderRadius,
  );
}

Color shadowColorGlobal = Colors.grey.withOpacity(0.2);
double defaultBlurRadius = 4.0;
double defaultSpreadRadius = 1.0;
double defaultRadius = 8.0;
List<BoxShadow> defaultBoxShadow({
  Color shadowColor,
  double blurRadius,
  double spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
}) {
  return [
    BoxShadow(
      color: shadowColor ?? shadowColorGlobal,
      blurRadius: blurRadius ?? defaultBlurRadius,
      spreadRadius: spreadRadius ?? defaultSpreadRadius,
      offset: offset,
    )
  ];
}

Decoration boxDecorationRoundedWithShadow(
  int radiusAll, {
  Color backgroundColor = Colors.white,
  Color shadowColor,
  double blurRadius,
  double spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
  LinearGradient gradient,
}) {
  return BoxDecoration(
    boxShadow: defaultBoxShadow(
      shadowColor: shadowColor ?? shadowColorGlobal,
      blurRadius: blurRadius ?? defaultBlurRadius,
      spreadRadius: spreadRadius ?? defaultSpreadRadius,
      offset: offset,
    ),
    color: backgroundColor,
    gradient: gradient,
    borderRadius: radius(radiusAll.toDouble()),
  );
}

BorderRadius radius([double radius]) {
  return BorderRadius.all(radiusCircular(radius ?? defaultRadius));
}

Radius radiusCircular([double radius]) {
  return Radius.circular(radius ?? defaultRadius);
}
