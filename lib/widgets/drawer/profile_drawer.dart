import 'dart:io';

import 'package:card_application/extensions/string_extension.dart';
import 'package:card_application/main.dart';
import 'package:card_application/states/dashboard_provider.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/utils/localization_manager.dart';
import 'package:card_application/widgets/select_language.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key, this.name}) : super(key: key);
  final String name;
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/profile_screen.jpg",
                      ),
                      radius: 30.0,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      name != null ? name : widget.name,
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ExpansionTile(
                      leading: Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      title: Text('maindrawer.p_set'.translate()),
                      children: [
                        SizedBox(
                          height: size.height * 0.010,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.030,
                            ),
                            Text("maindrawer.language".translate()),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.010,
                        ),
                        Divider(),
                        SizedBox(
                          height: size.height * 0.010,
                        ),
                        InkWell(
                          onTap: () async {
                            if (context.locale !=
                                LocalizationManager.instance.enLocale) {
                              context.locale =
                                  LocalizationManager.instance.enLocale;
                              await Get.rootController.restartApp();
                              await initPass();
                            }
                          },
                          child: SelectLanguage(
                            language: "English",
                            isSelected: context.locale ==
                                LocalizationManager.instance.enLocale,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (context.locale !=
                                LocalizationManager.instance.trLocale) {
                              context.locale =
                                  LocalizationManager.instance.trLocale;
                              await Get.rootController.restartApp();
                              await initPass();
                            }
                          },
                          child: SelectLanguage(
                            language: "Türkçe",
                            isSelected: context.locale ==
                                LocalizationManager.instance.trLocale,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  exit(0);
                },
                leading: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text('maindrawer.log_out'.translate()),
              )
            ],
          ),
        ],
      ),
    );
  }
}
