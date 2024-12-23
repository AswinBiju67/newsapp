import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:newsapp/model/newsmodel.dart';

class CategoryController with ChangeNotifier {
  int? selectedCategory = 0;
  List<String> categories = ["All", "sports", "health", "science", "technology"];
  List<Article> newsTopics = [];
  bool isLoading=false;

  // Fetch news based on selected category
  Future<void> getCategories({String? category}) async {
    String? categorydata = category ?? 'general'; 
    
    final url = Uri.parse(
      "https://newsapi.org/v2/top-headlines?category=$categorydata&apiKey=89103bbdfae1414fa176c6902266e58f",
    );

    try {
      isLoading=true;
      notifyListeners();
      log('Calling getCategories for category: $categorydata');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final articles = NewsModel.fromJson(data).articles ?? [];
        newsTopics = articles;
        log('Fetched articles for category $categorydata: ${articles.length}');
      } else {
        log('Failed to fetch news. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Exception occurred while fetching categories: $e');
    }
    isLoading=false;
    notifyListeners();
  }

  // Fetch top headlines from a source (e.g., BBC News)
  Future<void> topHeadlines() async {
    final url = Uri.parse(
     "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=89103bbdfae1414fa176c6902266e58f",
    );

    try {
      log('Calling topHeadlines');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final articles = NewsModel.fromJson(data).articles ?? [];
        newsTopics = articles;
        log(articles.length.toString());
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('Exception occurred while fetching top headlines: $e');
    }
    notifyListeners();
  }

  // Category selection handler
  void categorySelection({required int clickedIndex}) {
    selectedCategory = clickedIndex;
    // Fetch news based on selected category
    getCategories(category: selectedCategory == 0 ? null : categories[selectedCategory!]);
    notifyListeners();
}
}
