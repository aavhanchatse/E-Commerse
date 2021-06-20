import 'package:e_commerse/src/providers/productProvider.dart';
import 'package:e_commerse/src/screens/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool init = true;
  bool _loading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (init) {
      setState(() {
        _loading = true;
      });
      Provider.of<ProductProvider>(context, listen: false)
          .fetchData()
          .then((value) {
        setState(() {
          _loading = false;
        });
      });
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[300],
        title: Text('Categories'),
      ),
      body: FutureBuilder(
        future: Provider.of<ProductProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<ProductProvider>(
                builder: (context, value, _) => value.items.length <= 0
                    ? Text('No news added yet')
                    : GridView.builder(
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 2 / 1,
                        ),
                        itemCount: value.items.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(Products.routename, arguments: value.items[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  value.items[index]['name'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
