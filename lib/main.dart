import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'package:news_app/di.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/details/article_details_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/details/article_details_events.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/details/article_details_states.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_articles_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/pages/landing/daily_news.dart';
import 'package:news_app/features/daily_news/presentation/pages/landing/landing_screen.dart';

import 'features/daily_news/presentation/bloc/article/local/local_articles_events.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupLogging();
  Logger log = Logger("NewsApp");
  log.info("Starting NewsApp");
  try {
    await dotenv.load(fileName: ".env");
    log.info("Loaded .env file");
  } catch (e) {
    log.severe("Error loading .env file");
    log.severe(e);
  }
  try {
    await initdependencies();
    log.info("Initialized dependencies");
  } catch (e) {
    log.severe("Error initializing dependencies");
    log.severe(e);
  }
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL; // Set the logging level to ALL
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RemoteArticleBloc>(
              create: (context) => sl()
                ..add(const GetRemoteArticles())
                ..add(const GetLocalArticles())),
          BlocProvider<LocalArticlesBloc>(
              create: (context) => sl()..add(const LocalArticlesLoad())),
          BlocProvider<ArticleDetailsBloc>(
              create: (context) => sl()..add(const ArticleUnsavedEvent())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const LandingScreen(),
        ));
    return BlocProvider<RemoteArticleBloc>(
      create: (context) => sl()
        ..add(const GetRemoteArticles())
        ..add(const GetLocalArticles()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LandingScreen(),
      ),
    );
  }
}
