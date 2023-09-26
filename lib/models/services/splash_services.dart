import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/utils/routes/routes_name.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 2),
          () => Navigator.pushNamed(context, RoutesName.productList));
    } else
    {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushNamed(context, RoutesName.login);
      });
    }
  }
}
