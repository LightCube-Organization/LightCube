import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LightCube Start Page',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'LightCubeでプログラミング学習を開始'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title = "sample"}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 10;
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter = _counter * 10;
    });
  }

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    // final double size_width = MediaQuery.of(context).size.width;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login',
            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.headline4,
//            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 300, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'ID:'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (isEmpty(value!)) {
                    return 'Please provide a value.';
                  }
                  if (value.length <= 4) {
                    return 'id must be longer than 4 characters.';
                  }
                  if (16 < value.length) {
                    return 'id must be less than 16 characters.';
                  }
                  if (int.tryParse(value) == null) {
                    return 'no';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 300, vertical: 16),
              child: TextFormField(
                obscureText: !_showPassword,
                decoration: InputDecoration(
                    labelText: "password",
                    suffixIcon: IconButton(
                      icon: Icon(_showPassword
                          ? FontAwesomeIcons.solidEye
                          : FontAwesomeIcons.solidEyeSlash),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    )),
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (isEmpty(value!)) {
                    return 'Please provide a value.';
                  }
                  if (value.length <= 4) {
                    return 'id must be longer than 4 characters.';
                  }
                  if (16 < value.length) {
                    return 'id must be less than 16 characters.';
                  }
                  if (int.tryParse(value) == null) {
                    return 'no';
                  }
                  return null;
                },
              ),
            )
          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//    ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//Widget addLeadingIcon() {
//  return new Container(
//    padding: EdgeInsets.only(left: 10),
//    height: 50.0,
//    width: 50.0,
//    child: new Stack(
//      alignment: AlignmentDirectional.center,
//      children: <Widget>[
//        new Image.asset(
//          'images/logo.png',
//          width: 50.0,
//          height: 50.0,
//        )
//      ],
//    ),
//  );
//}

bool isEmpty(String s) {
  return s.isEmpty;
}
