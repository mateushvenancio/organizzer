import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organizzer/presenter/controllers/home_controller.dart';
import 'package:organizzer/presenter/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeController()),
        ],
        child: MainScreen(),
      ),
    );
  }
}
