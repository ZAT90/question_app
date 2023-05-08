part of 'question_bloc.dart';

@immutable
abstract class QuestionState {}

class QuestionInitial extends QuestionState {}

class GetQuestionList extends QuestionState {
  final List<QuestionModel> questionList;
  GetQuestionList({required this.questionList});
}

class GetQuestionData extends QuestionState {
  final List<String> questionToShow;
  final List<String> answerArray;
  final List<InteractionOptions> interactionOptions;
  final List<PostInteraction> postInteractionList;
  final String initialInstruction;
  final String finalAnswer;
  final QuestionModel questionModel;
  GetQuestionData(
      {required this.questionToShow,
      required this.initialInstruction,
      required this.answerArray,
      required this.interactionOptions,
      required this.postInteractionList,
      required this.finalAnswer,
      required this.questionModel});
}

class FillingProcessed extends QuestionState {
  final List<InteractionOptions> interactionOptions;
  final List<String> answerArray;

  FillingProcessed(
      {required this.answerArray, required this.interactionOptions});
}

class ListAfterUndo extends QuestionState {
  final List<String> answerArray;
  final List<InteractionOptions> interactionOptions;
  final List<int> prevPosToHighlightList;
  final int posToHighlight;

  ListAfterUndo(
      {required this.answerArray,
      required this.interactionOptions,
      required this.prevPosToHighlightList,
      required this.posToHighlight});
}

class FinalAnswerStatus extends QuestionState {
  final bool isCorrect;
  final String message;
  FinalAnswerStatus({required this.isCorrect, required this.message});
}
