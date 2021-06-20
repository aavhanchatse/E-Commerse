import 'dart:convert';
import 'package:e_commerse/src/helpers/dbHelper.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List categories = [];
  List products = [];

  List rankingList = [];

  List get rankings {
    return [...rankingList];
  }

  List _items = [];

  List get items {
    return [..._items];
  }

  Future<void> fetchData() async {
    final url = Uri.parse('https://stark-spire-93433.herokuapp.com/json');

    try {
      final response = await http.get(url);

      print(response.reasonPhrase);
      print(response.statusCode);

      final responseData = json.decode(response.body);
      final List categoriesData = responseData['categories'];
      final List rankingData = responseData['rankings'];

      for (var i = 0; i < categoriesData.length; i++) {
        final List productsList = categoriesData[i]['products'];

        if (productsList.isNotEmpty) {
          for (var j = 0; j < productsList.length; j++) {
            products.add({
              'id': productsList[j]['id'],
              'name': productsList[j]['name'],
              'variants': productsList[j]['variants'],
            });
          }
        }
      }

      for (var i = 0; i < categoriesData.length; i++) {
        final List productsList = categoriesData[i]['products'];

        if (productsList.isNotEmpty) {
          categories.add({
            'id': categoriesData[i]['id'],
            'name': categoriesData[i]['name'],
            'products': categoriesData[i]['products'],
          });
        } else {
          var productsDummyList;

          final List child_categories = categoriesData[i]['child_categories'];

          for (var j = 0; j < child_categories.length; j++) {
            final data = categoriesData
                .firstWhere((element) => element['id'] == child_categories[j]);

            productsDummyList = data['products'];
          }

          categories.add({
            'id': categoriesData[i]['id'],
            'name': categoriesData[i]['name'],
            'products': productsDummyList,
          });
        }
      }

      final List rankingProduct = [];

      rankingList.clear();

      for (var i = 0; i < rankingData.length; i++) {
        final List productItem = rankingData[i]['products'];

        for (var j = 0; j < productItem.length; j++) {
          final data = products
              .firstWhere((element) => element['id'] == productItem[j]['id']);

          final count = productItem[j]['view_count'] != null
              ? productItem[j]['view_count']
              : productItem[j]['order_count'] != null
                  ? productItem[j]['order_count']
                  : productItem[j]['shares'];

          rankingProduct.add({
            'data': data,
            'count': count,
          });
        }

        rankingList.add({
          'ranking': rankingData[i]['ranking'],
          'products': rankingProduct,
          // 'orderCount': rankingData[i]['order_count'],
        });
      }

      print('rankingList: $rankingList');

      for (var i = 0; i < categories.length; i++) {
        DBHelper.insert('category', {
          'id': categories[i]['id'],
          'name': categories[i]['name'],
          'products': jsonEncode(
            categories[i]['products'],
          ),
        });
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('category');

    _items = dataList
        .map(
          (e) => {
            'id': e['id'],
            'name': e['name'],
            'products': jsonDecode(e['products']),
          },
        )
        .toList();

    print('items in fetch: ${_items.last}');

    notifyListeners();
  }
}
