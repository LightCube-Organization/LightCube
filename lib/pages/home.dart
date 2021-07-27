import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:settings_ui/settings_ui.dart';
import '../main.dart';
import '../utils/constants.dart';
import '../components/auth_state.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var select = ['Single', 'Multi', 'Settings'];

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final menu = Container(
        color: theme.canvasColor,
        child: SafeArea(
            right: false,
            child: Drawer(
              elevation: 0,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text("Single"),
                    onTap: () {
                      // Using navigator key, because the widget is above nested navigator
                      navigatorKey.currentState!
                          .pushNamedAndRemoveUntil("Single", (r) => false);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.people),
                    title: Text("Multi"),
                    onTap: () {
                      navigatorKey.currentState!
                          .pushNamedAndRemoveUntil("Multi", (r) => false);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    onTap: () {
                      navigatorKey.currentState!
                          .pushNamedAndRemoveUntil("Settings", (r) => false);
                    },
                  ),
                ],
              ),
            )));

    return Row(
      children: <Widget>[
        Expanded(
          child: Navigator(
            key: navigatorKey,
            initialRoute: 'Single',
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(settings.name!),
                      ),
                      body: Container(
                        child: (() {
                          switch (settings.name!) {
                            case "Single":
                              return single();
                            case "Multi":
                              return multi();
                            case "Settings":
                              return preference();
                          }
                        })(),
                      ),
                      drawer: menu,
                    );
                  },
                  settings: settings);
            },
          ),
        ),
      ],
    );
  }
}

// 必要なら別ファイルに分離
Widget single() {
  final User? user = supabase.auth.currentUser;
  final ulength = user!.email.length - 8;
  String? uname = user.email.substring(0, ulength);

  return Container(
    padding: EdgeInsets.all(30),
    child: Row(children: <Widget>[
      Text(
        "Hello, $uname !",
        style: TextStyle(fontSize: 36),
      )
    ]),
  );
}

Widget multi() {
  final user = supabase.auth.user();
  final ulength = user!.email.length - 8;
  String? uname = user.email.substring(0, ulength);

  return Container(
    padding: EdgeInsets.all(30),
    child: Row(children: <Widget>[
      Text(
        "Hello, $uname !",
        style: TextStyle(fontSize: 36),
      )
    ]),
  );
}

Widget preference() {
  return Scaffold(
    body: SettingsList(
      sections: [
        SettingsSection(
          titlePadding: EdgeInsets.all(20),
          title: 'General',
          tiles: [
            SettingsTile(
              title: 'Language',
              subtitle: 'English',
              leading: Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: 'Volume',
              leading: Icon(Icons.volume_up),
              onPressed: (BuildContext context) {},
            ),
          ],
        ),
        SettingsSection(
          titlePadding: EdgeInsets.all(20),
          title: 'Account',
          tiles: [
            SettingsTile(
              title: 'Change password',
              leading: Icon(Icons.lock),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: 'Logout',
              leading: Icon(Icons.logout),
              onPressed: (BuildContext context) async {
                await supabase.auth.signOut();
                await Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (BuildContext context) => MyApp(),),ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ],
    ),
  );
}
