import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_bloc/config/custom_router.dart';
import 'package:instagram_bloc/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
      onGenerateRoute: CustomRouter.onGenerateRoute,
      initialRoute: SplashScreen.routeName,
    );
  }
}