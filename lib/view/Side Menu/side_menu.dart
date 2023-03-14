import 'package:construction_flutter_application/utils/global.dart';
import 'package:construction_flutter_application/view/Dashboard/dashboard.dart';
import 'package:construction_flutter_application/view/Login/login.view.dart';
import 'package:construction_flutter_application/view/Profile/user_profile.dart';
import 'package:construction_flutter_application/view/Project/projects_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int? userID;
  String? userRole;
  bool visible = false;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(
              "assets/images/asc.png",
            ),
          ),
          Visibility(
            visible: visible,
            child: DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashBoard()));
              },
            ),
          ),
          DrawerListTile(
            title: "Projects List",
            svgSrc: "assets/icons/list.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProjectsList()));
            },
          ),
          DrawerListTile(
            title: "Report",
            svgSrc: "assets/icons/report.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfile()));
            },
          ),
          DrawerListTile(
            title: "Log Out",
            svgSrc: "assets/icons/logout.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginView()));
            },
          ),
        ],
      ),
    );
  }

  void getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userID = pref.getInt('userID');
    userRole = pref.getString('userRole');
    setState(() {
      if (userRole == "Junior Site Engineer" || userRole == "Site Engineer") {
        visible = false;
      } else {
        visible = true;
      }
    });
  }
}

class DrawerListTile extends StatefulWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  State<DrawerListTile> createState() => _DrawerListTileState();
}

class _DrawerListTileState extends State<DrawerListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        widget.svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
