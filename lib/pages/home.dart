import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:settings_ui/settings_ui.dart';
import '../main.dart';
import '../utils/constants.dart';
import 'sample.dart';
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

  String uname = getUsername();

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
                      navigatorKey.currentState!.pushNamed("Single");
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.people),
                    title: Text(AppLocalizations.of(context)!.multi),
                    onTap: () {
                      navigatorKey.currentState!.pushNamed("Multi");
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(AppLocalizations.of(context)!.settings),
                    onTap: () {
                      navigatorKey.currentState!.pushNamed("Settings");
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
                        actions: <Widget>[
                          Icon(
                            Icons.account_circle,
                            size: 32,
                          ),
                          Center(
                              child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              uname,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ))
                        ],
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

String getUsername() {
  final User? user = supabase.auth.currentUser;
  final ulength = user!.email.length - 8;
  return user.email.substring(0, ulength);
}

// 必要なら別ファイルに分離
Widget single(context) {
  String uname = getUsername();

  return Container(
    padding: EdgeInsets.only(top: 30),
    child: Column(children: <Widget>[
      Text(
        "Hello, $uname !",
        style: TextStyle(fontSize: 36),
      ),
      Padding(
          padding: EdgeInsets.only(top: 30, left: 30, right:30),
          child: Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sample()),
                )
              },
              child: SizedBox(
                width: 350,
                height: 150,
                child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, right:10),
                    child: Text(AppLocalizations.of(context)!.getting_started,
                        style: TextStyle(fontSize: 24))),
              ),
            ),
          )),
    ]),
  );
}

Widget multi(context) {
  // DataTablesを使うと良くなるかもしれない
  // https://github.com/rodydavis/data_tables
  return FittedBox(
    child: Column(children: <Widget>[
      Container(
          padding: EdgeInsets.only(top: 10),
          child:Text(
              "Join the server",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24),
          )
      ),
      Padding(
        padding: EdgeInsets.only(top: 30, left: 30, right:30),
        child: DataTable(
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                'Server name',
                style: TextStyle(),
              ),
            ),
            DataColumn(
              label: Text(
                'Owner',
                style: TextStyle(),
              ),
            ),
            DataColumn(
              label: Text(
                'Join',
                style: TextStyle(),
              ),
            ),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(
                    Container(
                      width: MediaQuery.of(context).size.width / 10 * 3 - 90,
                      child:Text('Sample Server 1')
                    )
                ),
                DataCell(
                    Container(
                        width: MediaQuery.of(context).size.width / 10 * 5 - 90,
                        child:Text('John Doe')
                    )
                ),
                DataCell(
                  Container(
                    width: MediaQuery.of(context).size.width /10 * 2 - 90,
                    child: IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.login),
                    ),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Sample Server 2')),
                DataCell(Text('John Doe')),
                DataCell(
                  Center(
                    child: IconButton(
                      onPressed: () => {},
                      icon: Icon(Icons.login),
                    ),
                  ),
                ),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Sample Server 3')),
                DataCell(Text('John Doe')),
                DataCell(
                  Center(
                    child: IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.login),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
              title: AppLocalizations.of(context)!.profile,
              leading: Icon(Icons.person),
              onPressed: (BuildContext context) => {},
            ),
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
            SettingsTile(
              title: AppLocalizations.of(context)!.del_account,
              leading: Icon(Icons.delete),
              onPressed: (BuildContext context) {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                        title: Text(AppLocalizations.of(context)!.del_account),
                        content: Text(AppLocalizations.of(context)!.confirm),
                        actions: <Widget>[
                          TextButton(
                            // ダイアログを閉じる処理
                            child: Text("Cancel"),
                            onPressed: () {
                              // なぜか閉じず前の画面に戻る
                              //Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            // アカウントを削除する処理（Supabaseの秘密APIキーが必要）
                            child: Text("OK"),
                            onPressed: () {},
                          ),
                        ]);
                  },
                );
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
