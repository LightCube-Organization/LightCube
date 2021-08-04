import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';
import './home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key,}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {

  FormType? _formType = FormType.login;
  bool _showPassword = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(AppLocalizations.of(context)!.start),
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
                              title: Text(AppLocalizations.of(context)!.login),
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
                              title: Text(AppLocalizations.of(context)!.register),
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
                                  return AppLocalizations.of(context)!.provide_value;
                                }
                                if (value.length <= 4) {
                                  return AppLocalizations.of(context)!.id_long;
                                }
                                if (16 < value.length) {
                                  return AppLocalizations.of(context)!.id_less;
                                }
                                if (int.tryParse(value) == null) {
                                  return AppLocalizations.of(context)!.id_num;
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
                              return AppLocalizations.of(context)!.provide_value;
                            }
                            if (value.length <= 6) {
                              return AppLocalizations.of(context)!.pass_long;
                            }
                            if (int.tryParse(value) == null) {
                              return AppLocalizations.of(context)!.pass_num;
                            }
                            return null;
                          },
                          onSaved: (value) => _password = "$value",
                        )),
                    Padding(
                        padding: EdgeInsets.all(30),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:MaterialStateProperty.all(Colors.blue),
                            padding:MaterialStateProperty.all(EdgeInsets.all(20.0)),
                          ),
                          child: Text(AppLocalizations.of(context)!.submit),
                          onPressed: validateAndSubmit,
                        )),
                    Padding(
                        padding: EdgeInsets.all(30),
                        child: TextButton(
                          style: ButtonStyle(
                            padding:MaterialStateProperty.all(EdgeInsets.all(20.0)),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text(AppLocalizations.of(context)!.forgot),
                                  content: Text(AppLocalizations.of(context)!.remember),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("OK"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(AppLocalizations.of(context)!.forgot),
                        ),
                    ),
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

  // ログイン状態の保存を追加

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          await supabase.auth.signIn(email:_email, password:_password);
          final user = supabase.auth.user();
          print('Singed in: ${user!.email}');
          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => HomePage()),(_) => false);
        } else {
          await supabase.auth.signUp(_email, _password);
          await supabase.auth.signIn(email:_email, password:_password);
          final user = supabase.auth.user();
          print('Registered User: ${user!.email}');
          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => HomePage()),(_) => false);
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.error),
              content: Text("$e"),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
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