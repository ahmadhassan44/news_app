import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_articles_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_articles_state.dart';

import '../../widgets/article_tile.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocalArticlesBloc, LocalArticlesState>(builder: (_,state) {
        if(state is LocalArticlesLoading){
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if(state is LocalArticlesLoaded){
          if(state.articles!.isEmpty){
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text(
                    "No saved articles",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ]
              ),
            );
          } else {
            return ListView.builder(
              itemCount: state.articles!.length,
              itemBuilder: (_,index){
                return ArticleTile(article: state.articles![index]);
              },
            );
          }
        } else{
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
      }),
    );
  }
}
