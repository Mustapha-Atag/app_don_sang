import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'pages/home_page.dart';
import 'pages/prendre_rdv_page.dart';
import 'pages/remplir_infos_personels_page.dart';

import 'models/collecte_model.dart';
import 'providers/appProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AppProvider())],
      child: MaterialApp(
        title: 'Don de sang',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        //home: const MyHomePage(title: 'Don de sang'),
        initialRoute: '/',
        routes: {
          '/': ((context) => const MyHomePage(title: 'Don de sang')),
        },
        onGenerateRoute: (settings) {
          if (settings.name == PrendreRDVPage.routeName) {
            final args = settings.arguments as Map<String, dynamic>;

            return MaterialPageRoute(builder: (context) {
              return PrendreRDVPage(
                collecteData: args,
              );
            });
          } else if (settings.name == RemplirInfosPersonelPage.routeName) {
            final args = settings.arguments as Map<String, dynamic>;

            return MaterialPageRoute(builder: (context) {
              return RemplirInfosPersonelPage(params: args);
            });
          }

          return null;
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('fr'), Locale('en')],
      ),
    );
  }
}
