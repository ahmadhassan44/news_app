import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Daily News',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<RemoteArticleBloc,RemoteArticleState>(builder: (_,state) {
        if(state is RemoteArticlesLoading){
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if(state is RemoteArticlesLoaded){
          return ListView.builder(
            itemCount: state.articles!.length,
            itemBuilder: (_,index){
              return ListTile(
                title: Text(state.articles![index].title!),
              );
            },
          );
        } else {
          return Center(
            child: Text(state.error!.message),
          );
        }
      })
    );
  }

}
