import 'package:flutter/material.dart';

class RankedList extends StatelessWidget {
  static const String routename = '/rankedList';
  const RankedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)!.settings.arguments as Map;
    final List products = data['products'];

    print('data: $products');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[300],
        title: Text(data['ranking']),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          // childAspectRatio: 2 / 1,
        ),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue[100]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(products[index]['data']['name'], style: TextStyle(fontSize: 20),),
                SizedBox(height: 10),
                Text('Count'),
                Text(products[index]['count'].toString(), style: TextStyle(fontSize: 18),)
              ],
            ),
          );
        },
      ),
    );
  }
}
