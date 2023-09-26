import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shopping_cart/utils/routes/routes_name.dart';
import 'package:shopping_cart/utils/utils.dart';

class AuthProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final phoneNumber = TextEditingController();
  TextEditingController verifyCode = TextEditingController();
  TextEditingController forgetPassword = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
    phoneNumber.dispose();
    verifyCode.dispose();
    forgetPassword.dispose();
    firstName.dispose();
    lastName.dispose();

  }

  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(BuildContext context) {
    auth
        .signInWithEmailAndPassword(
            email: email.text.toString(), password: password.text.toString())
        .then((value) {
      Utils.toastMessage(value.user!.email.toString());
      Navigator.pushNamed(context, RoutesName.productList);
      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
    notifyListeners();
  }

  void signup(BuildContext context) {
    auth
        .createUserWithEmailAndPassword(
            email: email.text.toString(), password: password.text.toString())
        .then((value) {
      setLoading(false);
      password.clear();
      Navigator.pushNamed(context, RoutesName.login);
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      setLoading(false);
    });
  }
}
