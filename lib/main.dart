// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_pampotek/data/repositories/base_repository_impl.dart';
import 'package:flutter_pampotek/di.dart';
import 'package:flutter_pampotek/domain/usecases/add_obat.dart';
import 'package:flutter_pampotek/domain/usecases/add_transaksi.dart';
import 'package:flutter_pampotek/domain/usecases/delete_obat.dart';
import 'package:flutter_pampotek/domain/usecases/delete_transaksi.dart';
import 'package:flutter_pampotek/domain/usecases/get_obat.dart';
import 'package:flutter_pampotek/domain/usecases/get_transaksi.dart';
import 'package:flutter_pampotek/domain/usecases/update_obat.dart';
import 'package:flutter_pampotek/firebase_options.dart';
import 'package:flutter_pampotek/ui/add_obat_screen.dart';
import 'package:flutter_pampotek/ui/add_transaksi_screen.dart';
import 'package:flutter_pampotek/ui/edit_obat_screen.dart';
import 'package:flutter_pampotek/ui/home_screen.dart';
import 'package:flutter_pampotek/ui/login_screen.dart';
import 'package:flutter_pampotek/ui/providers/obat_provider.dart';
import 'package:flutter_pampotek/ui/providers/transaksi_provider.dart';
import 'package:flutter_pampotek/ui/register_screen.dart';
import 'package:provider/provider.dart';
import 'util.dart';
import 'theme.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  setup();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ObatProvider(
            addObatUseCase: AddObat(locator.get<ObatRepositoryImpl>()),
            deleteObatUseCase: DeleteObat(locator.get<ObatRepositoryImpl>()),
            editObatUseCase: EditObat(locator.get<ObatRepositoryImpl>()),
            getObatUseCase: GetObat(locator.get<ObatRepositoryImpl>()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => TransaksiProvider(
            addTransaksiUseCase:
                AddTransaksi(locator.get<TransaksiRepositoryImpl>()),
            deleteTransaksiUseCase:
                DeleteTransaksi(locator.get<TransaksiRepositoryImpl>()),
            getTransaksiUseCase:
                GetTransaksi(locator.get<TransaksiRepositoryImpl>()),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Pampotek',
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => _getInitialScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/addObat': (context) => const AddObatScreen(),
        '/editObat': (context) => const EditObatScreen(),
        '/addTransaksi': (context) => const AddTransaksiScreen(),
      },
    );
  }

  Widget _getInitialScreen() {
    final user = locator<AuthRepositoryImpl>().userSession();

    if (user != null) {
      return const HomeScreen();
    } else {
      return const LoginScreen();
    }
  }
}
