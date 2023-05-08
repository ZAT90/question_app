import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:question_app/model/question_model.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc() : super(QuestionInitial()) {
    on<LoadQuestionList>(
        (event, emit) async => await mapQuestionList(event, emit));
    on<MapQAtoDisplay>(
        (event, emit) async => await mapQAforAnswer(event, emit));
    on<FillWithCode>((event, emit) async => await mapAnswer(event, emit));
    on<StartUndo>((event, emit) async => await mapUndo(event, emit));
    on<CheckFinalAnswer>(
        (event, emit) async => await checkFinalAnswer(event, emit));
  }

  Future<void> mapQuestionList(
      LoadQuestionList event, Emitter<QuestionState> emit) async {
    var data = await rootBundle.loadString("assets/json/question.json");
    List decoded = json.decode(data);
    List<QuestionModel> questionList =
        decoded.map((item) => QuestionModel.fromJson(item)).toList();
    // printWrapped('Load questionModel list event: ${questionList}');
    emit(GetQuestionList(questionList: questionList));
  }

  Future<void> mapQAforAnswer(
      MapQAtoDisplay event, Emitter<QuestionState> emit) async {
    List<Widget> widgets = [];
    // print('map QNA');
    // printWrapped(event.questionModel.toString());
    // generating new list because otherwise the parent object gets updated due to bloc
    List<InteractionOptions> interactionOptions = event
        .questionModel.interactionOptions!
        .map((e) =>
            InteractionOptions(text: e.text, correctOption: e.correctOption))
        .toList();
    // print('pre interaction text: ' + interactionOptions.toString());
    List<String> splittedStringList =
        event.questionModel.preInteraction![1].text!.split(' ');
    List<String> mapSplitted = splittedStringList
        .map((splt) => splt.replaceAll(' ', '') == '_lcxn31' ? '' : splt)
        .toList();
    List<String> answerArray = [...mapSplitted];
    // print('splittedStringList: $splittedStringList');

    emit(GetQuestionData(
        questionModel: event.questionModel,
        questionToShow: mapSplitted,
        initialInstruction: event.questionModel.preInteraction![0].text!,
        interactionOptions: interactionOptions..shuffle(),
        answerArray: answerArray,
        postInteractionList: event.questionModel.postInteraction!,
        finalAnswer: event.questionModel.files![0].content!));
  }

  Future<void> mapAnswer(
      FillWithCode event, Emitter<QuestionState> emit) async {
    // print('start mapping answer: ');
    List<InteractionOptions> interactionOptions = event.interactionOptions;
    List<String> answerArray = [...event.answerArray];
    InteractionOptions interactionChosen = interactionOptions.firstWhere(
        (element) => element.text!.position! == event.interactionOptionPos);

    answerArray[event.answerArrayPosition] = interactionChosen.text!.text!;
    interactionChosen.correctOption = false;

    emit(FillingProcessed(
        answerArray: answerArray, interactionOptions: interactionOptions));
  }

  Future<void> mapUndo(StartUndo event, Emitter<QuestionState> emit) async {
    int lastIndex = event.prevPosToHighlightList.last;
    // print('lastIndex: $lastIndex');
    InteractionOptions interOptToChng = event.interactionOptions.firstWhere(
        (element) =>
            element.text!.text == event.answerArray[lastIndex] &&
            !element.correctOption!);
    // print('interOptToChng: $interOptToChng');
    interOptToChng.correctOption = true;
    // event.interactionOptions = event.interactionOptions.firstWhere((element) => false)
    event.answerArray[lastIndex] = '';
    int posToHighlight = lastIndex;
    event.prevPosToHighlightList.removeLast();

    emit(ListAfterUndo(
        answerArray: event.answerArray,
        interactionOptions: event.interactionOptions,
        prevPosToHighlightList: event.prevPosToHighlightList,
        posToHighlight: posToHighlight));
  }

  Future<void> checkFinalAnswer(
      CheckFinalAnswer event, Emitter<QuestionState> emit) async {
    String answerUser = event.answerArray.join();

    String finalAnswerJoined = event.finalAnswer.replaceAll(' ', '');

    PostInteraction postInteraction = event.postInteractionList.firstWhere(
        (element) => answerUser.toLowerCase() == finalAnswerJoined.toLowerCase()
            ? element.visiableIf!.toLowerCase() == 'correct'
            : element.visiableIf!.toLowerCase() == 'wrong');
    emit(FinalAnswerStatus(
        isCorrect: postInteraction.visiableIf!.toLowerCase() == 'correct',
        message: postInteraction.text!));
  }
}
