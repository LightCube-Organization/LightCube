import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:settings_ui/settings_ui.dart';
import '../main.dart';
import '../utils/constants.dart';
import 'single.dart';
import 'languages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    title: Text(AppLocalizations.of(context)!.single),
                    onTap: () {
                      // Using navigator key, because the widget is above nested navigator
                      navigatorKey.currentState!
                          .pushNamedAndRemoveUntil("Single", (r) => false);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.people),
                    title: Text(AppLocalizations.of(context)!.multi),
                    onTap: () {
                      navigatorKey.currentState!
                          .pushNamedAndRemoveUntil("Multi", (r) => false);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(AppLocalizations.of(context)!.settings),
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
                              return single(context);
                            case "Multi":
                              return multi(context);
                            case "Settings":
                              return preference(context);
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
Widget single(context) {
  final User? user = supabase.auth.currentUser;
  final ulength = user!.email.length - 8;
  String? uname = user.email.substring(0, ulength);

  return Container(
    padding: EdgeInsets.only(top: 30),
    child: Column(children: <Widget>[
      Text(
        "Hello, $uname !",
        style: TextStyle(fontSize: 36),
      ),
      Padding(
          padding: EdgeInsets.only(top: 30, left: 30),
          child: Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Single()),
                )
              },
              child: const SizedBox(
                width: 350,
                height: 150,
                child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                        'Getting Started',
                        style: TextStyle(fontSize: 24)
                    )
                ),
              ),
            ),
          )),
    ]),
  );
}

Widget multi(context) {
  final user = supabase.auth.user();
  final ulength = user!.email.length - 8;
  String? uname = user.email.substring(0, ulength);

  return Container(
    padding: EdgeInsets.all(30),
    child: Column(children: <Widget>[
      Text(
        "Hello, $uname !",
        style: TextStyle(fontSize: 36),
      )
    ]),
  );
}

Widget preference(context) {

  String locale = "";
  if (Localizations.localeOf(context).toString() == "en") {
    locale = "English";
  } else {
    locale = "日本語";
  }

  return Scaffold(
    body: SettingsList(
      sections: [
        SettingsSection(
          titlePadding: EdgeInsets.all(20),
          title: AppLocalizations.of(context)!.general,
          tiles: [
            SettingsTile(
              title: AppLocalizations.of(context)!.lang,
              subtitle: locale,
              leading: Icon(Icons.language),
              onPressed: (context) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => LanguagesScreen(),
                ));
              },
            ),
            SettingsTile(
              title: AppLocalizations.of(context)!.license,
              leading: Icon(Icons.account_balance),
              onPressed: (context) {
                showLicensePage(
                  context: context,
                  applicationName: 'LightCube',
                  applicationVersion: 'dev',
                  applicationLegalese: '2021 LightCube',
                );
              },
            ),
          ],
        ),
        SettingsSection(
          titlePadding: EdgeInsets.all(20),
          title: AppLocalizations.of(context)!.account,
          tiles: [
            SettingsTile(
              title: AppLocalizations.of(context)!.logout,
              leading: Icon(Icons.logout),
              onPressed: (BuildContext context) async {
                await supabase.auth.signOut();
                await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MyApp(),
                    ),
                    ModalRoute.withName('/'));
              },
            ),
          ],
        ),
        CustomSection(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Text(
                AppLocalizations.of(context)!.version + ': dev',
                style: TextStyle(color: Color(0xFF777777)),
              ),
            ),
          ],
        )),
      ],
    ),
  );
}
