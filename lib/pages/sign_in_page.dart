import 'package:fast_news/pages/register_page.dart';
import 'package:fast_news/services/auth.dart';
import 'package:fast_news/widgets/sign_in/sign_in_button.dart';
import 'package:fast_news/widgets/sign_in/sign_in_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
      appBar: AppBar(title: Text("Giriş Yap")),
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
              SizedBox(height: 12),
              SignInButton(
                type: "email",
                isRegister: false,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    var result = await _auth.signInWithEmail(mailController.text, passController.text);
                    if (result is FirebaseException) {
                      final snackBar = SnackBar(content: Text(result.message ?? "Bilinmeyen bir hata oluştu."));
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    }
                  }
                },
              ),
              SizedBox(height: 6),
              FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Text("Kayıt olmak için tıkla!", style: Theme.of(context).textTheme.headline6),
              ),
              Divider(),
              Text("Diğer Seçenekler", style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 6),
              SignInButton(
                type: "google",
                onPressed: () => _auth.signInGoogle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
