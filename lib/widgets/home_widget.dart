import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_workshop/states/articles_state.dart';
import 'package:provider/provider.dart';

import 'article_item_widget.dart';
import 'article_list_progress_indicator.dart';

class HomeWidget extends StatelessWidget {
  static const routeName = '/home';
  final String title;

  const HomeWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: _HomeBody(),
      );
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<ArticlesState>(
      builder: (context, articleState, _) => articleState.isLoading
          ? ArticleListProgressIndicator()
          : ListView.builder(
              itemBuilder: (context, index) =>
                  ArticleItemWidget(article: articleState.articles[index]),
              itemCount: articleState.articles.length,
            ));
}
