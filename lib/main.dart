import 'package:flutter/material.dart';
import 'package:flutter_workshop/states/articles_state.dart';
import 'package:flutter_workshop/widgets/article_item_widget.dart';
import 'package:flutter_workshop/widgets/article_list_progress_indicator.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (_) => ArticlesState()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      );
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: HomeBody(),
      );
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Consumer<ArticlesState>(
          builder: (context, articleState, _) =>
          articleState.isLoading
              ? ArticleListProgressIndicator()
              : ListView.builder(
            itemBuilder: (context, index) =>
                ArticleItemWidget(article: articleState.articles[index])
            ,
            itemCount: articleState.articles.length,
          ));
}
