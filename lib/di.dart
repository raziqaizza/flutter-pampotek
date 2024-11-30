import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_pampotek/data/repositories/base_repository_impl.dart';
import 'package:flutter_pampotek/data/repositories/transaksi_repository_impl.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<AuthRepositoryImpl>(AuthRepositoryImpl(FirebaseAuth.instance));
  locator.registerSingleton<ObatRepositoryImpl>(ObatRepositoryImpl(FirebaseDatabase.instance.ref()));
  locator.registerSingleton<TransaksiRepositoryImpl>(TransaksiRepositoryImpl(FirebaseDatabase.instance.ref()));

}
