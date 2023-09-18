import 'package:flutter/material.dart';
import 'package:shopping_cart/utils/routes/routes.dart';
import 'package:shopping_cart/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/view_model/cart_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>CartProvider())
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.productList ,
        onGenerateRoute: Routes.generateRoute
    ));
  }
}

