import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      home: LoginPage(title: 'LightCubeでプログラミング学習を開始'),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title = "sample"}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  FormType? _formType = FormType.login;
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
        body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 50.0,
            ),
            child: new Form(
              key: formKey,
              child: Center(
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Login or Register',
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 400.0),
                            child: RadioListTile<FormType>(
                              title: Text("Login"),
                              activeColor: Colors.blue,
                              value: FormType.login,
                              groupValue: _formType,
                              onChanged: moveToValue,
                            ))),
                    Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 400.0),
                            child: RadioListTile<FormType>(
                              title: Text("Register"),
                              activeColor: Colors.blue,
                              value: FormType.register,
                              groupValue: _formType,
                              onChanged: moveToValue,
                            ))),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                        ),
                        child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 700.0),
                            child: TextFormField(
                              decoration: InputDecoration(labelText: 'ID'),
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
                                  return 'Only numbers can be used as ID.';
                                }
                                return null;
                              },
                              // lccs.mlでなくてよい
                              onSaved: (value) => _email = "$value@lccs.ml",
                            ))),
                    ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 700.0),
                        child: TextFormField(
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                              labelText: "Password",
                              suffixIcon: IconButton(
                                icon: Icon(_showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
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
                              return 'ID must be longer than 4 characters.';
                            }
                            if (16 < value.length) {
                              return 'ID must be less than 16 characters.';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Only numbers can be used as passwords.';
                            }
                            return null;
                          },
                          onSaved: (value) => _password = "$value",
                        )),
                    Padding(
                        padding: EdgeInsets.all(30),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(20.0)),
                          ),
                          child: Text("Submit"),
                          onPressed: validateAndSubmit,
                        )),
                  ],
                ),
              ),
            )));
  }

  final formKey = new GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      // デバッグ用
      print('Form is valid. Email: $_email, password: $_password');
      return true;
    }
    // デバッグ用
    print('Form is Invalid. Email: $_email, password: $_password');
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
          print('Singed in: ${user.user}');
        } else {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password);
          print('Registered User: ${user.user}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToValue(value) {
    setState(() {
      _formType = value;
      print(value);
    });
  }
}

bool isEmpty(String s) {
  return s.isEmpty;
}
