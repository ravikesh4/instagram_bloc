import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_bloc/blocs/auth/auth_bloc.dart';
import 'package:instagram_bloc/blocs/simple_bloc_onserver.dart';
import 'package:instagram_bloc/config/custom_router.dart';
import 'package:instagram_bloc/repositories/repositories.dart';
import 'package:instagram_bloc/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    // context.read<AuthRepository>();
    // AuthRepository().logOut();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Instagram Bloc',
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
        ),
      ),
    );
  }
}
