import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  final TextEditingController mailController;
  final TextEditingController passController;
  final GlobalKey<FormState> formKey;

  const SignInForm({Key key, this.mailController, this.passController, this.formKey}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _isVisible = true;

  void _toggle() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: widget.mailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "E-Posta",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
            ),
            validator: validateEmail,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: widget.passController,
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
