import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organizzer/datasource/local_datasource/shared_preferences_compras_repository.dart';
import 'package:organizzer/datasource/local_datasource/shared_preferences_tarefas_repository.dart';
import 'package:organizzer/presenter/controllers/calendario_controller.dart';
import 'package:organizzer/presenter/controllers/compra_controller.dart';
import 'package:organizzer/presenter/controllers/home_controller.dart';
import 'package:organizzer/presenter/controllers/tarefas_controller.dart';
import 'package:organizzer/presenter/screens/calculadora_screen.dart';
import 'package:organizzer/presenter/screens/calendario_screen.dart';
import 'package:organizzer/presenter/screens/main_screen.dart';
import 'package:organizzer/presenter/screens/qr_code_screen.dart';
import 'package:organizzer/presenter/screens/splash_screen.dart';
import 'package:organizzer/presenter/screens/whatsapp_screen.dart';
import 'package:organizzer/repositories/i_compras_repository.dart';
import 'package:organizzer/repositories/i_tarefas_repository.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<IComprasRepository>(create: (_) => SharedPreferencesComprasRepository()),
        Provider<ITarefasRepository>(create: (_) => SharedPreferencesTarefasRepository()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (context) => TarefasController(context.read<ITarefasRepository>())),
        ChangeNotifierProvider(create: (context) => CompraController(context.read<IComprasRepository>())),
        ChangeNotifierProvider(create: (context) => CalendarioController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryVariant,
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp.router(
      title: 'Organizzer',
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return SplashScreen(
          onLoad: () async {
            await context.read<CompraController>().init();
            if (context.mounted) {
              await context.read<TarefasController>().init();
            }
          },
        );
      },
    ),
    GoRoute(
      path: '/main',
      builder: (context, state) => MainScreen(),
    ),
    GoRoute(
      path: '/qr',
      builder: (context, state) => QrCodeScreen(),
    ),
    GoRoute(
      path: '/whatsapp',
      builder: (context, state) => WhatsappScreen(),
    ),
    GoRoute(
      path: '/calculadora',
      builder: (context, state) => CalculadoraScreen(),
    ),
    GoRoute(
      path: '/calendario',
      builder: (context, state) => CalendarioScreen(),
    ),
  ],
);
