import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart/models/database/database_helper.dart';

import '../models/database/database_model/cart_model.dart';
import '../utils/utils.dart';

class CartProvider extends ChangeNotifier {
  DBHelper dbHelper = DBHelper();
  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getData() async {
    _cart = dbHelper.fetchData();
    return _cart;
  }

  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0;
  double get totalPrice => _totalPrice;

  void _setPrefItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("cart_item", _counter);
    pref.setDouble("total_price", _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _counter = pref.getInt("cart_item") ?? 0;
    _totalPrice = pref.getDouble("total_price") ?? 0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }

  void addTotalPrice(double productPrize) {
    _totalPrice = _totalPrice + productPrize;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrize) {
    _totalPrice = _totalPrice - productPrize;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrize() {
    _getPrefItems();
    return _totalPrice;
  }

  int addFinalQuantity(int quantity) {
    quantity++;
    notifyListeners();
    return quantity;
  }

  int addFinalPrice(int quantity, int price) {
    price = quantity * price;
    notifyListeners();
    return price;
  }
  // int subFinalQuantity(int quantity){
  //   quantity--;
  //   notifyListeners();
  //   return quantity;
  //
  // }
  // int subFinalPrice(int quantity ,int price){
  //   price = quantity * price;
  //   notifyListeners();
  //   return price;
  // }

  updateSubtractData(Cart cart) {
    // Utils.toastMessage("Item  Removed ${cart.quantity}");
    if (cart.quantity > 1) {
      // Utils.toastMessage("Item  Removed ${cart.quantity}");
      cart.productPrize = cart.productPrize - cart.intialPrize;
      cart.quantity = cart.quantity - 1;
      removeTotalPrice(cart.intialPrize.toDouble());
      dbHelper.updateData(cart).then((value) {
        Utils.toastMessage("Item Remains ${cart.quantity}");
      }).onError((error, stackTrace) {
        print(error);
        Utils.toastMessage("Error");
      });
      notifyListeners();
    }
  }

  updateAddData(Cart cart) {
    // Utils.toastMessage("Item  Removed ${cart.quantity}");
    cart.productPrize = cart.productPrize + cart.intialPrize;
    cart.quantity = cart.quantity + 1;
    addTotalPrice(cart.intialPrize.toDouble());
    dbHelper.updateData(cart).then((value) {
      Utils.toastMessage("Item Remains ${cart.quantity}");
    }).onError((error, stackTrace) {
      print(error);
      Utils.toastMessage("Error");
    });
    notifyListeners();
  }
}
