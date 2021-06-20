import 'package:e_commerse/src/app.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  static const String routename = '/products';
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)!.settings.arguments as Map;
    final List products = data['products'];

    print(data);
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
        elevation: 0,
        backgroundColor: Colors.blue[300],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[100]),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['name'],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Variants',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: item['variants'].length,
                      itemBuilder: (context, i) {
                        final variant = item['variants'][i];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(variant['color']),
                              Text('Price: Rs. ${variant['price']}'),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
