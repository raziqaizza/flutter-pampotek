import 'package:flutter/material.dart';

abstract class AuthRepository {
  Future<void> registerUser(
    BuildContext context,
    String email,
    String password,
  );

  Future<void> loginUser(
    BuildContext context,
    String email,
    String password,
  );

  Future<void> logoutUser();

  String? userSession();
}
