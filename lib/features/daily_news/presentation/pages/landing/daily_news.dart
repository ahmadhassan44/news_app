import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
        body: BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
            builder: (_, state) {
          if (state is RemoteArticlesLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is RemoteArticlesLoaded) {
            return ListView.builder(
              key: const PageStorageKey<String>('daily_news'),
              controller: scrollController,
              itemCount: state.articles!.length,
              itemBuilder: (_, index) {
                return ArticleTile(article: state.articles![index]);
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Image.asset(
                    "assets/images/wrong.png",
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  const Text(
                    "Something went wrong",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ]
              ),
            );
          }
        })
    );
  }
}
