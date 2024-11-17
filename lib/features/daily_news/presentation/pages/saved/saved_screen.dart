import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/details/article_details_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_articles_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_articles_events.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_articles_state.dart';
import 'package:news_app/features/daily_news/presentation/widgets/saved_article_tile.dart';

import '../../bloc/article/details/article_details_states.dart';
import '../../widgets/article_tile.dart';

final Logger log = Logger("SavedScreen");

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<ArticleDetailsBloc, ArticleDetailsState>(
            listener: (context, state) {
              if (state is ArticleSavedState || state is ArticleUnsavedState) {
                log.info("Article saved or unsaved from saved screen");
                context.read<LocalArticlesBloc>().add(const LocalArticlesLoad());
              }
            },
          ),
        ],
        child: BlocBuilder<LocalArticlesBloc, LocalArticlesState>(
          builder: (_, state) {
            if (state is LocalArticlesLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is LocalArticlesLoaded) {
              if (state.articles!.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No saved articles",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<LocalArticlesBloc>().add(const LocalArticlesLoad());
                  },
                  child: ListView.builder(
                    key: const PageStorageKey<String>('saved_screen'),
                    controller: scrollController,
                    itemCount: state.articles!.length,
                    itemBuilder: (_, index) {
                      return SavedArticleTile(article: state.articles![index]);
                    },
                  ),
                );
              }
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}