import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/models/database/database_helper.dart';
import 'package:shopping_cart/models/database/database_model/cart_model.dart';
import 'package:shopping_cart/view_model/cart_provider.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            "Cart",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 25, color: Colors.white),
          ),
        ),
        body: Consumer<CartProvider>(
          builder: (context, val, child) {
            return Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: val.getData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Cart>> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    String name =
                                        snapshot.data![index].productName;
                                    return Card(
                                        child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Row(children: [
                                              SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Image.network(snapshot
                                                    .data![index].image),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 4),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(name),
                                                    // Text(snapshot.data![0].productName, style: TextStyle(
                                                    //     fontSize: 18,
                                                    //     fontWeight: FontWeight.w600),),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          snapshot.data![index]
                                                              .unitTag,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          " \$" +
                                                              snapshot
                                                                  .data![index]
                                                                  .intialPrize
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Consumer<CartProvider>(
                                                builder: (context, val, child) {
                                                  return Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: InkWell(
                                                                  onTap: () {
                                                                    dbHelper
                                                                        .deletData(snapshot
                                                                            .data![
                                                                                index]
                                                                            .id)
                                                                        .then(
                                                                            (value) {
                                                                      val.removeTotalPrice(double.parse(snapshot
                                                                          .data![
                                                                              index]
                                                                          .productPrize
                                                                          .toString()));
                                                                      val.removeCounter();
                                                                    });
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete_forever,
                                                                    size: 30,
                                                                    color: Colors
                                                                        .black,
                                                                  ))),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          InkWell(
                                                            onTap: () {},
                                                            child: Container(
                                                              height: 35,
                                                              width: 100,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .green,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  InkWell(
                                                                      onTap:
                                                                          () {
                                                                        val.updateSubtractData(Cart(
                                                                            id: snapshot.data![index].id,
                                                                            productId: snapshot.data![index].id.toString(),
                                                                            productName: snapshot.data![index].productName,
                                                                            intialPrize: snapshot.data![index].intialPrize,
                                                                            productPrize: snapshot.data![index].quantity * snapshot.data![index].intialPrize,
                                                                            quantity: snapshot.data![index].quantity,
                                                                            unitTag: snapshot.data![index].unitTag,
                                                                            image: snapshot.data![index].image));
                                                                      },
                                                                      child: Icon(
                                                                          Icons
                                                                              .remove)),
                                                                  Text(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  InkWell(
                                                                      onTap:
                                                                          () {
                                                                        val.updateAddData(Cart(
                                                                            id: snapshot.data![index].id,
                                                                            productId: snapshot.data![index].id.toString(),
                                                                            productName: snapshot.data![index].productName,
                                                                            intialPrize: snapshot.data![index].intialPrize,
                                                                            productPrize: snapshot.data![index].intialPrize * snapshot.data![index].quantity,
                                                                            quantity: snapshot.data![index].quantity,
                                                                            unitTag: snapshot.data![index].unitTag,
                                                                            image: snapshot.data![index].image));
                                                                      },
                                                                      child: Icon(
                                                                          Icons
                                                                              .add))
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            ])));
                                  }),
                            )
                          ],
                        );
                      } else {
                        return CircularProgressIndicator(
                          color: Colors.white,
                        );
                      }
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Visibility(
                      visible: val.totalPrice == 0.0 ? false : true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sub-Total",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                          ),
                          Text(
                            val.totalPrice.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ))
              ],
            );
          },
        ));
  }
}
