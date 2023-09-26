import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/view_model/auth_provider.dart';
import '../res/components/round_button.dart';
import '../utils/utils.dart';

class ForgetScreen extends StatefulWidget {
  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 100, right: 20, left: 20),
          child: Consumer<AuthProvider>(
            builder: (context, val, child) {
              return Column(
                children: [
                  TextFormField(
                    controller: val.forgetPassword,
                    decoration: InputDecoration(
                      hintText: "Enter Your Email Id",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RoundButton(
                    text: "Forgot",
                    loading: val.loading,
                    onPress: () {
                      val.setLoading(true);
                      _auth
                          .sendPasswordResetEmail(
                              email: val.forgetPassword.text.toString().trim())
                          .then((value) {
                        Utils.toastMessage("CODE SENT IN GIVEN EMAIL");
                        val.setLoading(false);
                      }).onError((error, stackTrace) {
                        Utils.toastMessage(error.toString());
                        val.setLoading(false);
                      });
                    },
                  )
                ],
              );
            },
          )),
    );
  }
}
