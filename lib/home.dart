
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key,}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var select = ['Single', 'Multi', 'Settings'];

  final navigatorKey = GlobalKey<NavigatorState>();

  bool isMenuFixed(BuildContext context) {
    return MediaQuery.of(context).size.width > 800;
  }

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
        if (isMenuFixed(context)) menu,
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
                        padding: EdgeInsets.all(30),
                        child: (() {
                          switch (settings.name!) {
                            case "Single":
                              return single();
                            case "Multi":
                              return single();
                            case "Settings":
                              return Text("Under construction!!", style:TextStyle(fontSize: 36),);
                          }
                        })(),
                      ),
                      drawer: isMenuFixed(context) ? null : menu,
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
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final ulength = user!.email!.length - 8;
  String? uname = user.email!.substring(0, ulength);

  // 必要かわからない
  if (uname == null) {
    uname = "undefined";
  }

  return Container(
    child: Row(children: <Widget>[
      Text("Hello, $uname !", style: TextStyle(fontSize: 36),)
    ]),
  );
}
