import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organizzer/datasource/local_datasource/shared_preferences_categorias_repository.dart';
import 'package:organizzer/datasource/local_datasource/shared_preferences_compras_repository.dart';
import 'package:organizzer/datasource/local_datasource/shared_preferences_config_repository.dart';
import 'package:organizzer/presenter/controllers/categorias_controller.dart';
import 'package:organizzer/presenter/controllers/compra_controller.dart';
import 'package:organizzer/presenter/controllers/config_controller.dart';
import 'package:organizzer/presenter/controllers/home_controller.dart';
import 'package:organizzer/presenter/screens/add_compra_screen.dart';
import 'package:organizzer/presenter/screens/calculadora_screen.dart';
import 'package:organizzer/presenter/screens/main_screen.dart';
import 'package:organizzer/presenter/screens/qr_code_screen.dart';
import 'package:organizzer/presenter/screens/splash_screen.dart';
import 'package:organizzer/presenter/screens/whatsapp_screen.dart';
import 'package:organizzer/repositories/i_categorias_repository.dart';
import 'package:organizzer/repositories/i_compras_repository.dart';
import 'package:organizzer/repositories/i_config_repository.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<IComprasRepository>(create: (_) => SharedPreferencesComprasRepository()),
        Provider<IConfigRepository>(create: (_) => SharedPreferencesConfigRepository()),
        Provider<ICategoriasRepository>(create: (_) => SharedPreferencesCategoriasRepository()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (context) => ConfigController(context.read<IConfigRepository>())),
        ChangeNotifierProvider(create: (context) {
          return CategoriasController(
            context.read<ICategoriasRepository>(),
            context.read<IComprasRepository>(),
          );
        }),
        ChangeNotifierProvider(create: (context) => CompraController(context.read<IComprasRepository>())),
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
          onLoad: [
            SplashAwaiter((context) => context.read<CompraController>().init()),
            SplashAwaiter((context) => context.read<CategoriasController>().init()),
            SplashAwaiter((context) => context.read<ConfigController>().init()),
          ],
          // onLoad: () async {
          //   await context.read<CompraController>().init();
          //   if (context.mounted) {
          //     await context.read<CategoriasController>().init();
          //     await context.read<ConfigController>().init();
          //     // await context.read<TarefasController>().init();
          //   }
          // },
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
      path: '/compra_form',
      builder: (context, state) => CompraFormScreen(),
    ),
  ],
);
