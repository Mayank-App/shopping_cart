import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/res/app_string.dart';
import 'package:shopping_cart/utils/routes/routes_name.dart';
import 'package:shopping_cart/view_model/auth_provider.dart';

import '../res/components/round_button.dart';
import '../utils/utils.dart';

class SigninScreen extends StatefulWidget {
  @override
  State<SigninScreen> createState() => _SignInState();
}

class _SignInState extends State<SigninScreen> {
  ValueNotifier<bool> obscurePassword= ValueNotifier<bool>(true);
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 45,horizontal: 20),
            child: Column(
              children: [

                Image.asset(
                  "assets/images/shopping-cart-logoo.png",
                  scale: 6,
                ),
                Text(
                  AppString.welcome,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  AppString.signin,
                  style: TextStyle(
                      color: Colors.lightBlue.shade900,
                      fontWeight: FontWeight.w600,
                      fontSize: 28),
                ),
                SizedBox(height: 50,),
                Consumer<AuthProvider>(
                  builder: (context, value1, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: value1.firstName,
                                          focusNode: value1.firstNameFocus,
                                          onFieldSubmitted: (val){
                                            Utils.fieldFocusNode(context, value1.firstNameFocus,value1.lastNameFocus);
                                          },
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: Colors.black)),
                                            hintText: 'First Name',

                                          ),
                                          validator: (value) {
                                            if (value!.toString().trim().isEmpty) {
                                              return 'Enter First Name';
                                            } else {
                                              return null;
                                            }
                                          }),
                                    ),
                                   SizedBox(width: 10,),
                                    Expanded(
                                      child: TextFormField(

                                        controller: value1.lastName,
                                          focusNode: value1.lastNameFocus,
                                          onFieldSubmitted: (val){
                                            Utils.fieldFocusNode(context, value1.lastNameFocus,value1.emailFocus);
                                          },
                                          keyboardType: TextInputType.text,

                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.black)),
                                            hintText: 'Last Name',
                                          ),
                                          validator: (value) {
                                            if (value!.toString().trim().isEmpty) {
                                              return 'Enter Last Name';
                                            } else {
                                              return null;
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 25,),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: value1.email,
                                  focusNode: value1.emailFocus,
                                  onFieldSubmitted: (val){
                                    Utils.fieldFocusNode(context, value1.emailFocus,value1.passwordFocus);
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.purple,
                                    ),
                                    hintText: 'Email',
                                  ),
                                  validator: (value) {
                                    if (value!.toString().trim().isEmpty) {
                                      return 'Enter email';
                                    } else if (!(value.contains("@"))) {
                                      return " @ should be used";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                ValueListenableBuilder(valueListenable: obscurePassword, builder: (context,value,child){
                                  return TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: value1.password,
                                    focusNode: value1.passwordFocus,
                                    onFieldSubmitted: (val){
                                      Utils.fieldFocusNode(context, value1.passwordFocus,value1.passwordFocus);
                                    },
                                    obscureText: obscurePassword.value,
                                    decoration:  InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.black)),
                                      prefixIcon: Icon(Icons.lock, color: Colors.purple),
                                     suffixIcon: IconButton(onPressed: (){
                                       obscurePassword.value =! obscurePassword.value;
                                     }, icon:Icon(Icons.change_circle,color: Colors.purple,)),
                                      hintText: 'Password',
                                    ),
                                    validator: (value) {
                                      if (value!.toString().trim().isEmpty) {
                                        return 'Enter password';
                                      } else if (value.length < 6) {
                                        return " Enter atleast 6 digit password";
                                      } else {
                                        return null;
                                      }
                                    },
                                  );
                                })
                              ],
                            )),
                        SizedBox(
                          height: 50,
                        ),
                        RoundButton(
                          text: "Sign up ",
                          loading: value1.loading,
                          onPress: () {
                            Utils.hideKeyboard(context);
                            if (_formKey.currentState!.validate()) {
                              value1.setLoading(true);
                              value1.signup(context);
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.login);
                                },
                                child: Text('Login'))
                          ],
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
