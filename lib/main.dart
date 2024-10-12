import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/account_setting.dart';
import 'Screens/get_started_page.dart';
import 'Screens/home_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/singup_screen.dart';
import 'Screens/splesh_screen.dart';
import 'Screens/transaction_history_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: isAuthenticated ? '/home' : '/login',
      initialRoute: '/splashScreen',
      getPages: [
        GetPage(name: '/splashScreen', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/getStarted', page: () =>  const GetStartedPage()),
        GetPage(name: '/signup', page: () =>  SignupScreen()),
        GetPage(name: '/transactionHistory', page: () => TransactionHistory()),
        GetPage(name: '/accountSetting', page: () => AccountSetting()),
        GetPage(name: '/home', page: () => HomeScreen()),

      ],
    );
  }
}


