import 'package:flutter/material.dart';
import 'package:flutter_workshop/states/articles_state.dart';
import 'package:flutter_workshop/widgets/article_view.dart';
import 'package:flutter_workshop/widgets/home_widget.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (_) => ArticlesState()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeWidget(title: 'Flutter Demo Home Page'),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case ArticleView.routeName:
                return MaterialPageRoute(
                    builder: (context) =>
                        ArticleView(article: settings.arguments),
                    settings: RouteSettings(name: ArticleView.routeName));
              default:
                return MaterialPageRoute(
                    builder: (context) => HomeWidget(),
                    settings: RouteSettings(name: HomeWidget.routeName));
            }
          },
        ),
      );
}
