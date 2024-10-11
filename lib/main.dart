
import 'package:bandoan/firebase_options.dart';
import 'package:bandoan/model/restaurant.dart';
import 'package:bandoan/page/cart_page.dart';
import 'package:bandoan/page/delivery_progress_page.dart';
import 'package:bandoan/page/home_page.dart';
import 'package:bandoan/page/payment.dart';
import 'package:bandoan/page/settings_page.dart';
import 'package:bandoan/service/auth/auth_gate.dart';
import 'package:bandoan/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

        ChangeNotifierProvider(create: (context) => Restaurant())
      ],
      child: const MyApp(),
      )
      );
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //router
      routes: {
        '/home' : (context) => const HomePage(),
        '/settings' : (context) => const SettingsPage(),
        '/cart' : (context) => const CartPage(),
        '/payment' : (context) => const Payment(),
        '/delivery_progress' : (context) => const DeliveryProgressPage(),
        
      },

      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
