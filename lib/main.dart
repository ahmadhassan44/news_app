import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'package:news_app/di.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/pages/home/daily_news.dart';

void main() async {
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
    return BlocProvider<RemoteArticleBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DailyNews(),
      ),
    );
  }
}
