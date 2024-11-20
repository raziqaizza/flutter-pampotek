import 'package:flutter/material.dart';
import 'package:flutter_pampotek/data/controller.dart';
import 'package:flutter_pampotek/theme.dart';
import 'package:flutter_pampotek/ui/home_screen.dart';
import 'package:flutter_pampotek/ui/login_screen.dart';
import '../../util.dart';
import '../../theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController _authController = AuthController();

  void handleRegister() {
    String name = namaController.text;
    String email = emailController.text;
    String password = passwordController.text;

    _authController.registerUser(context, email, password);
  }

  void toLoginScreen() {
    Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");

    MaterialTheme theme = MaterialTheme(textTheme);

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      decoration: BoxDecoration(color: MaterialTheme.lightScheme().surface),
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        children: [
          const MyHeaderText(text: "Daftarkan akun kamu."),
          MyTextForm(
            hint: "Nama",
            controller: namaController,
          ),
          MyTextForm(
            hint: "Email Address",
            controller: emailController,
          ),
          MyTextForm(
            hint: "Password",
            controller: passwordController,
          ),
          MyButton(
            text: "Daftar",
            onPressed: handleRegister,
          ),
          MyTextButton(text: "Sudah punya akun?", onPressed: toLoginScreen),
        ],
      ),
    )));
  }
}

class MyTextForm extends StatelessWidget {
  const MyTextForm({super.key, required this.hint, required this.controller});

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType = TextInputType.text;

    if (this.hint == "Email Address") {
      keyboardType = TextInputType.emailAddress;
    } else {
      keyboardType = TextInputType.text;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        style: TextStyle(color: MaterialTheme.lightScheme().onSurfaceVariant),
        decoration: InputDecoration(
          labelText: hint,
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: MaterialTheme.lightScheme().onSurfaceVariant)),
        ),
      ),
    );
  }
}

class MyHeaderText extends StatelessWidget {
  const MyHeaderText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 120, 0, 36),
        child: Text(text, style: Theme.of(context).textTheme.headlineMedium));
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.text, required this.onPressed});

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(48),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: MaterialTheme.lightScheme().primaryContainer,
            textStyle: TextStyle(
                color: MaterialTheme.lightScheme().onPrimaryContainer),
            minimumSize: Size(120, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}

class MyTextButton extends StatelessWidget {
  const MyTextButton({super.key, required this.text, required this.onPressed});

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(48),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          textStyle: TextStyle(
              color: MaterialTheme.lightScheme().onPrimaryContainer,
              decoration: TextDecoration.underline),
        ),
        child: Text(text, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
