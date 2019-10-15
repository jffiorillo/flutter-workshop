import 'dart:async';
import 'dart:convert' as json;

import 'package:built_value/serializer.dart';
import 'package:flutter_workshop/model/article.dart';
import 'package:flutter_workshop/model/story_type.dart';
import 'package:http/http.dart' as http;

import 'exceptions.dart';

class HackerNewsApi {
  static const _rootUrl = "https://hacker-news.firebaseio.com/v0/";

  Future<List<Article>> fetch(StoriesType type) async {
    List<int> ids = await _fetchIds(type);
    final futureArticles = ids
        .map<Future<Article>>((articleId) async {
          try {
            return await _getArticle(articleId);
          } on HackerNewsApiException catch (e) {
            print(e);
          }
          return null;
        })
        .where((item) => item != null)
        .toList(growable: false);
    return await Future.wait(futureArticles);
  }

  Future<List<int>> _fetchIds(StoriesType type) async {
    final idResponse = await http.get(_generateUrl(type));
    return parseStoryIds(idResponse.body).take(10).toList(growable: false);
  }

  Future<Article> _getArticle(int id) async {
    var storyUrl = '${_rootUrl}item/$id.json';
    try {
      var storyRes = await http.get(storyUrl);
      if (storyRes.statusCode == 200 && storyRes.body != null) {
        return parseArticle(storyRes.body);
      } else {
        throw HackerNewsApiException(statusCode: storyRes.statusCode);
      }
    } on DeserializationError {
      throw HackerNewsApiException(
          statusCode: 200, message: "Article was not parseable.");
    } on http.ClientException {
      throw HackerNewsApiException(message: "Connection failed.");
    }
  }

  List<int> parseStoryIds(String jsonStr) =>
      List<int>.from(json.jsonDecode(jsonStr));

  String _generateUrl(StoriesType type) =>
      '$_rootUrl${(type == StoriesType.topStories ? 'top' : 'new')}stories.json';
}
