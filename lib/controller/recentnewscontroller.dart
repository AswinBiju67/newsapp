import 'package:flutter/material.dart';
import 'package:newsapp/model/newsmodel.dart';
import 'package:http/http.dart' as http;

class Recentnewscontroller with ChangeNotifier{
  NewsModel? recentnewss;
  bool isLoading = false;
  int selectedindex = 0;
    List<NewsModel> product=[];
      List catagories = [];


  Future<void> getproducts({String? categroy}) async {
    String endpointUrl= categroy == null ? "https://newsapi.org/v2/top-headlines?country=us&apiKey=89103bbdfae1414fa176c6902266e58f" : "https://newsapi.org/v2/${categroy}?country=us&apiKey=89103bbdfae1414fa176c6902266e58f";
    final url = Uri.parse(endpointUrl);
    try {
      notifyListeners();
      final response = await http.get(url);
      if (response.statusCode == 200) {
        product = productModelFromJson(response.body);
      }
    } catch (e) {}
    notifyListeners();
  }

  onCategerySelection({required int clickedindex}) {
    selectedindex = clickedindex;
    getproducts(categroy: selectedindex == 0 ? null : catagories[selectedindex]);  //to change calegroy on ui on selecting categroy
    notifyListeners();
  }
}