import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './pages/splash_page.dart';
import './pages/login_page.dart';
import './pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(
    url: 'https://jcmiulxstrkxxnobczrr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyNzM1ODE3NywiZXhwIjoxOTQyOTM0MTc3fQ.0Q1_hkQoEvn10It4oxK2S8Gst3_rtRxamMOn1Wsb0gc',
    authCallbackUrlHostname: 'login-callback',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LightCube Start Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => LoginPage(),
        '/home': (_) => HomePage(),
      },
    );
  }
}
