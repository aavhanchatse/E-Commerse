import 'package:e_commerse/src/app.dart';
import 'package:e_commerse/src/providers/productProvider.dart';
import 'package:e_commerse/src/screens/rankedList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Ranking extends StatelessWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final List items = provider.rankingList;
    print(items);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sort'),
        backgroundColor: Colors.blue[300],
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final data = items[index];

          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(RankedList.routename, arguments: data);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[100]),
                child: Center(child: Text(data['ranking'])),
              ),
            ),
          );
        },
      ),
    );
  }
}
