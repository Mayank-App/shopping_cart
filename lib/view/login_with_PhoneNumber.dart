import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/utils/routes/routes_name.dart';
import 'package:shopping_cart/view_model/auth_provider.dart';

import '../res/components/round_button.dart';
import '../utils/utils.dart';

class LoginWithPhone extends StatefulWidget {
  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  //  var loading = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<AuthProvider>(
          builder: (context, value, child) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: value.phoneNumber,
                  decoration: InputDecoration(hintText: "+1 234 5678 987"),
                ),
                SizedBox(
                  height: 50,
                ),
                RoundButton(
                    text: "Login",
                    loading: value.loading,
                    onPress: () {
                      value.setLoading(true);

                      _auth.verifyPhoneNumber(
                          phoneNumber: value.phoneNumber.text.toString().trim(),
                          verificationCompleted: (_) {
                            value.setLoading(false);
                          },
                          verificationFailed: (e) {
                            value.setLoading(false);
                            Utils.toastMessage(e.toString());
                          },
                          codeSent: (String verificationId, int? token) {
                            Navigator.pushNamed(context, RoutesName.verifyCode,
                                arguments: {"verification": verificationId});
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCode(
                            //    verification:verificationId  ,
                            // )));
                            value.setLoading(false);
                          },
                          codeAutoRetrievalTimeout: (e) {
                            value.setLoading(false);
                            Utils.toastMessage(e.toString());
                          });
                    })
              ],
            );
          },
        ),
      ),
    );
  }
}
