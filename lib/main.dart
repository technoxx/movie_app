import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/login_screen.dart';
import 'package:movie_app/widgets/favourite_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavouriteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        home: UserLoginPage(),
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
