import 'dart:io';

import 'package:card_application/database/db_helper.dart';
import 'package:card_application/extensions/string_extension.dart';
import 'package:card_application/main.dart';
import 'package:card_application/model/pic.dart';
import 'package:card_application/states/dashboard_provider.dart';
import 'package:card_application/utils/functions.dart';
import 'package:card_application/utils/localization_manager.dart';
import 'package:card_application/widgets/select_language.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key, this.name}) : super(key: key);
  final String name;
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  DbHelper _db = DbHelper();
  var _image;
  var imagePicker;
  var type;
  File img;
  PicModel profilePicture = PicModel();
  List<PicModel> picData;
  bool setLoading = false;
  @override
  void initState() {
    picData = [];

    _getPic();

    super.initState();
  }

  _getPic() async {
    setState(() {
      setLoading = false;
    });

    picData = await _db.getPicture();
    try {
      img = File(picData[0].pic);
      setState(() {
        setLoading = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        setLoading = true;
      });
    }
  }

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
                    GestureDetector(
                      onTap: () async {
                        var source = type = ImageSource.gallery;
                        XFile image =
                            await ImagePicker().pickImage(source: source);
                        setState(() {
                          _image = File(image.path);
                        });

                        profilePicture.pic = image.path;
                        await _db.insertPicture(profilePicture);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        radius: 30.0,
                        child: setLoading
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 28.0,
                                child: picData != null &&
                                        picData.isNotEmpty &&
                                        picData[0].pic != "" &&
                                        picData[0].pic != null &&
                                        img != null
                                    ? ClipOval(child: Image.file(img))
                                    : Image.asset(
                                        "assets/add_photo.png",
                                        scale: size.height * 0.012,
                                        color: Colors.black87,
                                      ),
                              )
                            : CircularProgressIndicator(),
                      ),
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
