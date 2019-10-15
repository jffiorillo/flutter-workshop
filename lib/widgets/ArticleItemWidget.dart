import 'package:flutter/widgets.dart';
import 'package:flutter_workshop/model/article.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;

  const ArticleItemWidget({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(child: Text(article.title)),
  );
}
