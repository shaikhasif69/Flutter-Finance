import 'package:flutter/material.dart';
import 'package:flutter_finance/router/named_routes.dart';
import 'package:flutter_finance/services/auth_services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  String? userName;
  String? email;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? 'Guest';
      email = prefs.getString('email') ?? 'No email';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(userName ?? 'Guest'),
            accountEmail: Text(email ?? 'No email'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.update),
            title: Text('Update Profile'),
            onTap: () =>
                GoRouter.of(context).pushNamed(UserRoutes.personalInfo),
          ),
          ListTile(
            leading: Icon(Icons.golf_course_sharp),
            title: Text('New Financial Goals'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Financial Advice'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.newspaper),
            title: Text('News'),
            onTap: () =>
                GoRouter.of(context).pushNamed(UserRoutes.newsHomePage),
          ),
          ListTile(
            leading: Icon(Icons.handshake),
            title: Text('Opportunities'),
            onTap: () =>{}
                // GoRouter.of(context).pushNamed(UserRoutes.newsHomePage),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.help_center),
            title: Text('Helps & FAQs'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
