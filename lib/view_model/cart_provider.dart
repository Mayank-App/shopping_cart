import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/database/database_model/cart_model.dart';
class CartProvider extends ChangeNotifier{

     int _counter=0;
     int get counter => _counter;

     double _totalPrice=0;
     double get totalPrice => _totalPrice;

     void _setPrefItems()async{
       SharedPreferences pref = await SharedPreferences.getInstance();
       pref.setInt("cart_item", _counter);
       pref.setDouble("total_price", _totalPrice);
       notifyListeners();
     }

     void _getPrefItems()async{
       SharedPreferences pref = await SharedPreferences.getInstance();
      pref.getInt("cart_item");
       pref.getDouble("total_price");
       notifyListeners();

     }
     void addCounter(){
       _counter++;
       _setPrefItems();
       notifyListeners();
     }

     void removeCounter(){
       _counter--;
       _setPrefItems();
       notifyListeners();
     }

     int getCounter(){
       _getPrefItems();
       return _counter;
     }
     void addTotalPrice(double productPrize){
       _totalPrice=_totalPrice+productPrize;
       _setPrefItems();
       notifyListeners();
     }

     void removeTotalPrice(double productPrize){
       _totalPrice =_totalPrice-productPrize;
       _setPrefItems();
       notifyListeners();
     }

     double getTotalPrize(){
       _getPrefItems();
       return _totalPrice;
     }

     addToDB(Cart cart) async {

     }
}