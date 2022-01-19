import 'package:card_application/states/dashboard_provider.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/views/mainscreens/home_screen.dart';
import 'package:card_application/views/mainscreens/statistic_screen.dart';
import 'package:card_application/widgets/dialogs/common_dialogs.dart';
import 'package:card_application/widgets/drawer/profile_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WADashboardScreen extends StatefulWidget {
  static String tag = '/WADashboardScreen';

  @override
  WADashboardScreenState createState() => WADashboardScreenState();
}

class WADashboardScreenState extends State<WADashboardScreen> {
  int _selectedIndex = 0;
  var _pages = <Widget>[
    WAHomeScreen(),
    WAStatisticScreen(),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashProvider>(
        builder: (context, value, child) => WillPopScope(
              onWillPop: () {
                CommonDialogs.callLogout();
                return;
              },
              child: Scaffold(
                key: value.dashkey,
                drawer: MainDrawer(),
                body: _pages.elementAt(_selectedIndex),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.miniCenterDocked,
                floatingActionButton: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FloatingActionButton(
                    backgroundColor: WAPrimaryColor,
                    child:
                        Icon(Icons.qr_code_scanner_sharp, color: Colors.white),
                    onPressed: () {
                      /*    push(WAQrScannerScreen()); */
                    },
                  ),
                ),
                bottomNavigationBar: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  clipBehavior: Clip.antiAlias,
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    currentIndex: _selectedIndex,
                    onTap: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: WAPrimaryColor,
                    unselectedItemColor: Colors.grey,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.date_range), label: 'Statistics'),
                    ],
                  ),
                ),
              ),
            ));
  }
}
