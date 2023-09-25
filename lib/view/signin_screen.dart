import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/utils/routes/routes_name.dart';
import 'package:shopping_cart/view_model/auth_provider.dart';

import '../res/components/round_button.dart';
import '../utils/utils.dart';

class SigninScreen extends StatefulWidget{
  @override
  State<SigninScreen> createState() => _SignInState();
}

class _SignInState extends State<SigninScreen> {
  final _formKey =GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Sign up"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<AuthProvider>(builder: (context, value,child) { return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: value.email,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return'Enter email';
                        }
                        else if (!(value.contains("@"))){
                          return " @ should be used";
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.text ,
                      controller: value.password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password_sharp),
                        hintText: 'Password',
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return'Enter password';
                        }
                        else if( value.length <6 ){
                          return " Enter atleast 6 digit password";
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                  ],
                )),
            SizedBox(height: 50,),
            RoundButton( text: "Sign up ",
                loading: value.loading,
                onPress: (){
           if(_formKey.currentState!.validate()){
              value.setLoading(true);
                  value.signup(context);
                }
            },),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RoutesName.login);
                },
                    child: Text('Login')
                )
              ],
            )

          ],
        );  },)
      ),

    );
  }
}