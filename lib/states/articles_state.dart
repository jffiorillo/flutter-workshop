import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_workshop/api/api.dart';
import 'package:flutter_workshop/model/article.dart';
import 'package:flutter_workshop/model/story_type.dart';

class ArticlesState with ChangeNotifier {
  List<Article> _articles = [];
  bool _isLoading = false;

  final HackerNewsApi api = HackerNewsApi();

  ArticlesState(){
    refresh();
  }

  UnmodifiableListView<Article> get articles => UnmodifiableListView(_articles);


  bool get isLoading => _isLoading;

  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();
    _articles = await api.fetch(StoriesType.topStories);
    _isLoading = false;
    notifyListeners();
  }
}
