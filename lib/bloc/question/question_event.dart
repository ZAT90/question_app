part of 'question_bloc.dart';

@immutable
abstract class QuestionEvent {}

class LoadQuestionList extends QuestionEvent {}

class MapQAtoDisplay extends QuestionEvent {
  final QuestionModel questionModel;
  MapQAtoDisplay({required this.questionModel});
}

class FillWithCode extends QuestionEvent {
  final List<InteractionOptions> interactionOptions;
  final List<String> answerArray;
  final int answerArrayPosition;
  final int interactionOptionPos;
  FillWithCode(
      {required this.interactionOptionPos,
      required this.answerArray,
      required this.answerArrayPosition,
      required this.interactionOptions});
}

class StartUndo extends QuestionEvent {
  final List<String> answerArray;
  final List<InteractionOptions> interactionOptions;
  final List<int> prevPosToHighlightList;

  StartUndo({
    required this.answerArray,
    required this.interactionOptions,
    required this.prevPosToHighlightList,
  });
}

class CheckFinalAnswer extends QuestionEvent {
  final List<PostInteraction> postInteractionList;
  final String finalAnswer;
  final List<String> answerArray;
  CheckFinalAnswer(
      {required this.postInteractionList,
      required this.finalAnswer,
      required this.answerArray});
}
