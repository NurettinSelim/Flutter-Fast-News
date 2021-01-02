import 'package:fast_news/pages/news_page.dart';
import 'package:fast_news/pages/sign_in_page.dart';
import 'package:fast_news/services/auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  final Stream _user = AuthService().userStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _user,
      builder: (context, snapshot) => snapshot.data == null ? SignInPage() : NewsPage(),
    );
  }
}
