import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/controller/dummydb.dart';

import 'package:newsapp/model/newsmodel.dart';
import 'package:http/http.dart' as http;

class Newscontroller with ChangeNotifier {
  NewsModel? news;
  NewsModel? allnews;
  NewsModel? recentnewss;
  int selectedindex = 0;
  bool isLoading = false;
  NewsModel? newscategory;
  List catagories = Dummydb().list;

  Future<void> getnews() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=89103bbdfae1414fa176c6902266e58f");
    try {
      isLoading = true;
      notifyListeners();
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode >= 200) {
        print("success");
        log(response.body.toString());
        news = NewsModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getallnews() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines/sources?apiKey=89103bbdfae1414fa176c6902266e58f");
    try {
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode >= 200) {
        print("success");
        log(response.body.toString());
        allnews = NewsModel.fromJson(jsonDecode(response.body));
      } else {}
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> recentnews() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=recent&apiKey=89103bbdfae1414fa176c6902266e58f");
    try {
      isLoading = true;
      notifyListeners();
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode >= 200) {
        print("success");
        log(response.body.toString());
        recentnewss = NewsModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  
}
