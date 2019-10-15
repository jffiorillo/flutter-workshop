import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_workshop/model/article.dart';
import 'package:flutter_workshop/widgets/article_view.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;

  const ArticleItemWidget({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => Navigator.pushNamed(context, ArticleView.routeName,
            arguments: article),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12),
          child: Container(
              child: ListTile(
            title: Text(article.title),
          )),
        ),
      );
}
