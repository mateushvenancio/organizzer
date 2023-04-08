import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organizzer/presenter/controllers/compra_controller.dart';
import 'package:organizzer/presenter/controllers/home_controller.dart';
import 'package:organizzer/presenter/controllers/tarefas_controller.dart';
import 'package:organizzer/presenter/screens/main_screen.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: AppColors.primaryVariant, // status bar color
    ));

    return MaterialApp(
      title: 'Organizzer',
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeController()),
          ChangeNotifierProvider(create: (_) => TarefasController()),
          ChangeNotifierProvider(create: (_) => CompraController()),
        ],
        child: MainScreen(),
      ),
    );
  }
}
