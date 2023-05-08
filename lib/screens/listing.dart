import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_app/bloc/question/question_bloc.dart';
import 'package:question_app/constants/constants.dart';
import 'package:question_app/model/question_model.dart';
import 'package:question_app/screens/question.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({super.key});

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  List<QuestionModel> questionList = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionBloc, QuestionState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is GetQuestionList) {
          questionList = state.questionList;
        }
      },
      child: BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Container(
                width: Constants(context).width,
                height: Constants(context).height,
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(20),
                child: ListView.separated(
                  itemCount: questionList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                       // print('question tap: ${questionList[index].interactionOptions}');
                       // return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    BlocProvider<QuestionBloc>(
                                      create: (context) => QuestionBloc()
                                        ..add(MapQAtoDisplay(
                                            questionModel:
                                                questionList[index])),
                                      //    create: (context) {questionBloc.add(event)},
                                      child: const QuestionScreen(),
                                    ))));
                      },
                      shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(5)),
                      title: Text(
                        questionList[index].files![0].codeLanguage!,
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(questionList[index].files![0].name!),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10,
                  ),
                ),
              ));
        },
      ),
    );
  }
}
