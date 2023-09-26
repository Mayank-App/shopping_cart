import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/models/database/database_helper.dart';
import 'package:shopping_cart/models/database/database_model/cart_model.dart';
import 'package:shopping_cart/utils/routes/routes_name.dart';
import 'package:shopping_cart/utils/utils.dart';
import 'package:shopping_cart/view_model/auth_provider.dart';
import 'package:shopping_cart/view_model/cart_provider.dart';

class ProductListView extends StatefulWidget {
  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  DBHelper dbHelper = DBHelper();
  final _auth = FirebaseAuth.instance;
  List<String> productName = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Grapes',
    'Kiwi',
    'Mango',
    'Orange',
    'Peach',
    'Strawberry',
    'Blueberry',
    'Pineapple',
    'Watermelon',
    'Lemon',
    'Avocado',
    'Raspberry',
    'Cranberry',
    'Pear',
    'Apricot',
  ];
  List<int> productPrize = [
    80,
    60,
    70,
    120,
    130,
    50,
    60,
    110,
    90,
    140,
    125,
    145,
    30,
    40,
    60,
    160,
    145,
    75,
    125
  ];
  List<String> productUnit = [
    'KG', // Apple
    'dazon', // Banana
    'KG', // Cherry
    'KG', // Date
    'KG', // Grapes
    'KG', // Kiwi
    'KG', // Mango
    'KG', // Orange
    'KG', // Peach
    'KG', // Strawberry
    'kg', // Blueberry
    'piece', // Pineapple
    'KG', // Watermelon
    'KG', // Lemon
    'piece', // Avocado
    'KG', // Raspberry
    'KG', // Cranberry
    'KG', // Pear
    'dozen', // Apricot
  ];

  List<String> productImage = [
    'https://media.istockphoto.com/id/184276818/photo/red-apple.jpg?s=612x612&w=0&k=20&c=NvO-bLsG0DJ_7Ii8SSVoKLurzjmV0Qi4eGfn6nW3l5w=',
    'https://m.media-amazon.com/images/I/51ebZJ+DR4L._AC_UF1000,1000_QL80_.jpg',
    'https://media.istockphoto.com/id/172315512/photo/sweet-cherries.jpg?s=612x612&w=0&k=20&c=qz6b92ZkcMTH5XtZUMI7CW7CQPkYFo1qAWoHX48VQk4=',
    'https://images.immediate.co.uk/production/volatile/sites/30/2020/02/dates-resized-14ee31f.jpg?quality=90&resize=556,505',
    'https://media.istockphoto.com/id/803721418/photo/grape-dark-grape-grapes-with-leaves-isolated-with-clipping-path-full-depth-of-field.jpg?s=612x612&w=0&k=20&c=-jAJlO3WbgFzxwwSmG3pc7bqUva117TYUKKrQW3-RK8=',
    'https://cdn.britannica.com/45/126445-050-4C0FA9F6/Kiwi-fruit.jpg',
    'https://c.ndtvimg.com/2023-05/3ph40r2_mango_625x300_02_May_23.jpg?im=FaceCrop,algorithm=dnn,width=1200,height=675',
    'https://media.istockphoto.com/id/185284489/photo/orange.jpg?s=612x612&w=0&k=20&c=m4EXknC74i2aYWCbjxbzZ6EtRaJkdSJNtekh4m1PspE=',
    'https://media.istockphoto.com/id/1151868959/photo/single-whole-peach-fruit-with-leaf-and-slice-isolated-on-white.jpg?s=612x612&w=0&k=20&c=RLTbnKnN6w85oXn4qA8y8WYN3OMpGxEDc1nI7VY0gWU=',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Garden_strawberry_%28Fragaria_%C3%97_ananassa%29_single2.jpg/800px-Garden_strawberry_%28Fragaria_%C3%97_ananassa%29_single2.jpg',
    'https://www.chandigarhayurvedcentre.com/wp-content/uploads/2021/03/BLUEBERRY.jpg',
    'https://images.news18.com/ibnlive/uploads/2022/07/shutterstock_1403484713.jpg',
    'https://ayu.health/blog/wp-content/uploads/2023/06/watermelon-isolated-white-clippi-1024x820.webp',
    'https://media.istockphoto.com/id/1406047398/photo/lemon-with-leaf-isolated-on-white-background.webp?b=1&s=170667a&w=0&k=20&c=zszKjT13Ros7Yt_8Ofv2eJdWTYB-DpuCPr8cvWAIgGs=',
    'https://images.unsplash.com/photo-1601039641847-7857b994d704?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YXZvY2Fkb3xlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Raspberry_-_whole_%28Rubus_idaeus%29.jpg/1200px-Raspberry_-_whole_%28Rubus_idaeus%29.jpg',
    'https://www.freshproduceshoppe.com/wp-content/uploads/2018/09/frt-cranberries-pkt-freshproduceshoppe-1024x1024.jpg',
    'https://img.freepik.com/free-vector/vintage-pear-illustration_53876-112720.jpg?w=2000',
    'https://www.freshproduceshoppe.com/wp-content/uploads/2018/09/apricot-freshproduceshoppe-1024x1024.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product List",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
        actions: [
          Consumer<AuthProvider>(
            builder: (context, val, child) {
              return IconButton(
                  onPressed: () {
                    _auth.signOut().then((value) {
                      Navigator.pushNamed(context, RoutesName.login);
                      val.email.clear();
                      val.password.clear();
                    }).onError((error, stackTrace) {
                      Utils.toastMessage(error.toString());
                    });
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ));
            },
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.cartList);
            },
            child: Badge(
              label: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(value.getCounter().toString());
                },
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: productName.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                    productImage[index].toString())),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productName[index].toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          productUnit[index].toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "  \$${productPrize[index]}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Consumer<CartProvider>(
                                          builder: (context, val, child) {
                                            return InkWell(
                                              onTap: () async {
                                                await dbHelper
                                                    .insertIntoDB(Cart(
                                                        id: index,
                                                        productId:
                                                            index.toString(),
                                                        productName:
                                                            productName[index],
                                                        intialPrize:
                                                            productPrize[index],
                                                        productPrize:
                                                            productPrize[index],
                                                        quantity: 1,
                                                        unitTag:
                                                            productUnit[index]
                                                                .toString(),
                                                        image:
                                                            productImage[index]
                                                                .toString()))
                                                    .then((value) {
                                                  Utils.toastMessage(
                                                      "Item Added in Cart");
                                                  val.addCounter();
                                                  val.addTotalPrice(
                                                      double.parse(
                                                          productPrize[index]
                                                              .toString()));
                                                }).onError((error, stackTrace) {
                                                  Utils.toastMessage(
                                                      "Already Item Added in Cart");
                                                });
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Center(
                                                    child: Text(
                                                  "Add to cart",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                              ),
                                            );
                                          },
                                        ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
