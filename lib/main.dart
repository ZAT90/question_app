import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_app/bloc/question/question_bloc.dart';
import 'package:question_app/config/simpleBlocObserver.dart';
import 'package:question_app/constants/constants.dart';
import 'package:question_app/screens/listing.dart';
import 'package:question_app/screens/question.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Question App',
      initialRoute: Constants.list,
      routes: {
        Constants.list: (context) => BlocProvider(
              create: (context) => QuestionBloc()..add(LoadQuestionList()),
              child: const QuestionList(),
            ),
        Constants.question: (context) => const QuestionScreen(),
      },
      // home: Scaffold(
      //   body: Center(
      //     child: Text('Hello World1!'),
      //   ),
      // ),
    );
  }
}
