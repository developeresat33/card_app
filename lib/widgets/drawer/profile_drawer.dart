import 'dart:ui';

import 'package:card_application/mainscreens/login_page.dart';
import 'package:card_application/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key key}) : super(key: key);

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
                    Text("Profil Adı")
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      title: Text("Profil Sayfası"),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      title: Text("Ayarlar"),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Get.offAll(() => LoginScreen());
                },
                leading: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text("Çıkış Yap"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
