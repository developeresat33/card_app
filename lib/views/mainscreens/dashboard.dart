import 'package:card_application/states/dashboard_provider.dart';
import 'package:card_application/states/provider_header.dart';
import 'package:card_application/utils/colors.dart';
import 'package:card_application/views/mainscreens/home_screen.dart';
import 'package:card_application/views/mainscreens/statistic_screen.dart';
import 'package:card_application/widgets/dialogs/common_dialogs.dart';
import 'package:card_application/widgets/drawer/profile_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WADashboardScreen extends StatefulWidget {
  static String tag = '/WADashboardScreen';
  final String name;
  WADashboardScreen({this.name});
  @override
  WADashboardScreenState createState() => WADashboardScreenState();
}

class WADashboardScreenState extends State<WADashboardScreen> {
  int _selectedIndex = 0;
  var _pages;

  @override
  void initState() {
    _pages = <Widget>[
      HomeScreen(
        name: widget.name,
      ),
      StatisticScreen(),
    ];
    ProviderHeader.dshprovider.getOverViewList();
    ProviderHeader.dshprovider.dashkey = GlobalKey<ScaffoldState>();
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
                drawer: MainDrawer(
                  name: widget.name,
                ),
                body: _pages.elementAt(_selectedIndex),
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
