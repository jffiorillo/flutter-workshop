import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_workshop/model/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatelessWidget {
  static const routeName = '/article_details';
  final Article article;

  const ArticleView({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: _buildContent(context));

  Widget _buildContent(BuildContext context) => WebView(
        initialUrl: article.url,
        javascriptMode: JavascriptMode.unrestricted,
      );
}
