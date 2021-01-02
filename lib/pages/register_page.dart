import 'package:fast_news/services/auth.dart';
import 'package:fast_news/widgets/sign_in/sign_in_button.dart';
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

  bool _isVisible = true;

  void _toggle() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: mailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "E-Posta",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                      ),
                      validator: validateEmail,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passController,
                      decoration: InputDecoration(
                        labelText: "Şifre",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                        suffixIcon: IconButton(
                          icon: _isVisible ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                          onPressed: () => _toggle(),
                        ),
                      ),
                      obscureText: _isVisible,
                    ),
                  ],
                ),
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

  String validateEmail(String value) {
    Pattern pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Geçerli bir e-posta adresi giriniz';
    else
      return null;
  }
}
