import 'package:fast_news/services/auth.dart';
import 'package:fast_news/widgets/sign_in/sign_in_button.dart';
import 'package:fast_news/widgets/sign_in/sign_in_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final mailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Kayıt Ol")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              SignInForm(
                formKey: _formKey,
                mailController: mailController,
                passController: passController,
              ),
              SizedBox(height: 16),
              SignInButton(
                type: "email",
                isRegister: true,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    var result = await _auth.registerWithEmail(mailController.text, passController.text);
                    if (result is FirebaseException) {
                      final snackBar = SnackBar(content: Text(result.message ?? "Bilinmeyen bir hata oluştu."));
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    } else
                      Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
