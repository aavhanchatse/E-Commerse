import 'package:e_commerse/src/providers/productProvider.dart';
import 'package:e_commerse/src/screens/mainTab.dart';
import 'package:e_commerse/src/screens/products.dart';
import 'package:e_commerse/src/screens/rankedList.dart';
import 'package:flutter/material.dart';
import 'package:e_commerse/src/screens/home.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'E-Commerse',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainTab(),
        routes: {
          Products.routename: (context) => Products(),
          RankedList.routename: (context) => RankedList(),
        },
      ),
    );
  }
}