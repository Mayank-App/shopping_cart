import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/utils/routes/routes_name.dart';
import 'package:shopping_cart/view/product_list_screen.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.productList:
        return MaterialPageRoute(builder: (BuildContext context)=>ProductListView());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text("No routes are there"),
            ),
          );
        });
    }

  }
}