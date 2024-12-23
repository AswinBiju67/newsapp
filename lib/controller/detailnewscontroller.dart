import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:newsapp/model/newsmodel.dart';
import 'package:http/http.dart' as http;

class Productcontroller with ChangeNotifier{
  NewsModel? product;
  bool isLoading=false;
  Future<void> getproducts( String newsid) async {
    final url = Uri.parse("https://newsapi.org/v2/top-headlines/sources?apiKey=89103bbdfae1414fa176c6902266e58f");
    try {
      isLoading=true;
      notifyListeners();
      final response = await http.get(url);
      if (response.statusCode == 200) {
        product = NewsModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {}
    isLoading=false;
    notifyListeners();
  }
}