import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_app/bloc/question/question_bloc.dart';
import 'package:question_app/constants/constants.dart';
import 'package:question_app/model/question_model.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<String> questionToShow = [];
  List<String> answerArray = [];
  List<InteractionOptions> interactionOptions = [];
  String initialInstruction = '';
  List<int> prevPosToHighlightList = [];
  int posToHighlight = 0;
  List<PostInteraction> postInteractionList = [];
  String finalAnswer = '';
  QuestionModel? questionModel;

  @override
  Widget build(BuildContext context) {
    final questionBloc = BlocProvider.of<QuestionBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<QuestionBloc, QuestionState>(
        listener: (context, state) {
          if (state is GetQuestionData) {
            questionModel = state.questionModel;
            questionToShow = state.questionToShow;
            initialInstruction = state.initialInstruction;
            interactionOptions = state.interactionOptions;
            answerArray = state.answerArray;
            postInteractionList = state.postInteractionList;
            finalAnswer = state.finalAnswer;
            String question =
                answerArray.firstWhere((element) => element.isEmpty);
            posToHighlight = answerArray.indexOf(question);
            print('posToHighlight on start: $posToHighlight');
          } else if (state is FillingProcessed) {
            interactionOptions = state.interactionOptions;
            prevPosToHighlightList.add(posToHighlight);
            answerArray = state.answerArray;
            String question = answerArray
                .firstWhere((element) => element.isEmpty, orElse: () => '');
            posToHighlight = answerArray.indexOf(question);
            // print('posToHighlight: $posToHighlight');
          } else if (state is ListAfterUndo) {
            interactionOptions = state.interactionOptions;
            prevPosToHighlightList = state.prevPosToHighlightList;
            answerArray = state.answerArray;
            posToHighlight = state.posToHighlight;
          } else if (state is FinalAnswerStatus) {
            // print('state iscorrect: ${state.isCorrect}');
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) => AlertDialog(
                      title: Text(state.isCorrect ? 'Correct' : 'Wrong'),
                      content: Text(state.message),
                      actions: [
                        state.isCorrect
                            ? const SizedBox.shrink()
                            : TextButton(
                                onPressed: () {
                                  questionBloc.add(MapQAtoDisplay(
                                      questionModel: questionModel!));
                                  Navigator.pop(context);
                                },
                                child: const Text('retry')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('done'))
                      ],
                    ));
          }
        },
        child: BlocBuilder<QuestionBloc, QuestionState>(
          builder: (context, state) {
            return Container(
              width: Constants(context).width,
              height: Constants(context).height,
              alignment: Alignment.topCenter,

              // padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          color: Colors.purple, child: questionWidget())),
                  Expanded(flex: 2, child: answerOptionsWidget(questionBloc))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Column answerOptionsWidget(QuestionBloc questionBloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Click on the appropriate answer below to fill in the highlighted box above',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            posToHighlight == -1
                ? CircleAvatar(
                    backgroundColor: Colors.purple,
                    child: IconButton(
                        onPressed: () {
                          questionBloc.add(CheckFinalAnswer(
                              postInteractionList: postInteractionList,
                              finalAnswer: finalAnswer,
                              answerArray: answerArray));
                        },
                        icon: const Icon(Icons.play_arrow)),
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              width: 20,
            ),
            !listEquals(questionToShow, answerArray)
                ? CircleAvatar(
                    backgroundColor: Colors.green,
                    child: IconButton(
                        onPressed: () {
                          questionBloc.add(StartUndo(
                              answerArray: answerArray,
                              interactionOptions: interactionOptions,
                              prevPosToHighlightList: prevPosToHighlightList));
                        },
                        icon: const Icon(Icons.undo)))
                : const SizedBox.shrink(),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < interactionOptions.length; i++)
              interactionOptions[i].correctOption!
                  ? Row(
                      children: [
                        TextButton(
                            key: Key(interactionOptions[i]
                                .text!
                                .position
                                .toString()),
                            onPressed: () {
                              questionBloc.add(FillWithCode(
                                  answerArray: answerArray,
                                  answerArrayPosition: posToHighlight,
                                  interactionOptionPos:
                                      interactionOptions[i].text!.position!,
                                  interactionOptions: interactionOptions));
                            },
                            style: TextButton.styleFrom(
                                side: const BorderSide(width: 2),
                                backgroundColor: Colors.greenAccent),
                            child: Text(interactionOptions[i].text!.text!)),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    )
                  : const SizedBox()
          ],
        ),
      ],
    );
  }

  Column questionWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          initialInstruction,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < questionToShow.length; i++)
              questionToShow[i].isEmpty
                  ? Row(
                      children: [
                        Container(
                          height: 30,
                          constraints: const BoxConstraints(minWidth: 30),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                  width: 2,
                                  color: posToHighlight == i
                                      ? Colors.red
                                      : Colors.transparent)),
                          child: Text(
                            '${answerArray[i]}',
                            key: Key(i.toString()),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    )
                  : Text(
                      '${questionToShow[i]} ',
                      style: const TextStyle(color: Colors.white),
                    )
          ],
        ),
      ],
    );
  }
}
