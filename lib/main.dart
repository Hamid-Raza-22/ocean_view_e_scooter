
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocean_view_e_scooters/Screens/AdminDashboard/admin_panel.dart';

import 'Screens/GT_SL_scooter.dart';
import 'Screens/account_setting.dart';
import 'Screens/get_started_page.dart';
import 'Screens/home_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/scooters_screen.dart';
import 'Screens/singup_screen.dart';
import 'Screens/splesh_screen.dart';
import 'Screens/transaction_history_screen.dart';
import 'Services/FirebaseServices/firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Add this line
  // Check if Firebase has already been initialized
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green, // Set primary color to green
      ),      //initialRoute: isAuthenticated ? '/home' : '/login',
      initialRoute: '/splashScreen',
      getPages: [
        GetPage(name: '/splashScreen', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/adminPanel', page: () => const AdminPanel()),
        GetPage(name: '/getStarted', page: () =>  const GetStartedPage()),
        GetPage(name: '/signup', page: () =>  SignupScreen()),
        GetPage(name: '/transactionHistory', page: () => TransactionHistory()),
        GetPage(name: '/accountSetting', page: () => AccountSetting()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/scooters', page: () => ScootersScreen()),
        GetPage(name: '/GTSLscooters', page: () => GTSLScootersScreen()),

      ],
    );
  }
}


