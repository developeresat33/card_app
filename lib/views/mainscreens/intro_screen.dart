import 'package:card_application/extensions/string_extension.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/utils/localization_manager.dart';
import 'package:card_application/views/mainscreens/login_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<PageViewModel> pageList = [];

  @override
  Widget build(BuildContext context) {
    pageList = [
      PageViewModel(
        title: "intro_screen.t1".translate(),
        bodyWidget: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("intro_screen.t1_d".translate())],
          ),
        ),
        image: Center(
            child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: size.height * 0.2,
                width: size.height * 0.4,
                child: Image.asset(
                  context.locale == LocalizationManager.instance.enLocale
                      ? "assets/TE1.jpg"
                      : "assets/TT1.jpg",
                  fit: BoxFit.fill,
                )),
          ),
        )),
      ),
      PageViewModel(
        title: "intro_screen.t2".translate(),
        bodyWidget: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("intro_screen.t2_d".translate())],
          ),
        ),
        image: Center(
            child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.15,
              width: size.height * 0.45,
              child: Image.asset(
                context.locale == LocalizationManager.instance.enLocale
                    ? "assets/TE2.jpg"
                    : "assets/TT2.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
        )),
      ),
      PageViewModel(
        title: "intro_screen.t3".translate(),
        bodyWidget: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("intro_screen.t3_d".translate())],
          ),
        ),
        image: Center(
            child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: size.height * 0.32,
                width: size.height * 0.27,
                child: Image.asset(
                  context.locale == LocalizationManager.instance.enLocale
                      ? "assets/TE3.jpg"
                      : "assets/TT3.jpg",
                  fit: BoxFit.fill,
                )),
          ),
        )),
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: context.width,
        height: context.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover)),
        child: IntroductionScreen(
          globalBackgroundColor: Colors.transparent,
          pages: pageList,
          onDone: () {
            // When done button is press
          },
          onSkip: () {
            // You can also override onSkip callback
          },
          showSkipButton: true,
          skip: InkWell(
            onTap: () => Get.offAll(() => (LoginScreen())),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.skip_next),
                SizedBox(
                  width: size.width * 0.020,
                ),
                Text("intro_screen.skip".translate(),
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          next: Icon(Icons.arrow_right),
          done: InkWell(
              onTap: () => Get.offAll(() => (LoginScreen())),
              child: Text("intro_screen.done".translate(),
                  style: TextStyle(fontWeight: FontWeight.w600))),
          dotsDecorator: DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: WAPrimaryColor,
              color: Colors.black26,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0))),
        ),
      ),
    );
  }
}
