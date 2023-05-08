class QuestionModel {
  String? id;
  List<PreInteraction>? preInteraction;
  InteractionModule? interactionModule;
  List<PostInteraction>? postInteraction;
  List<Files>? files;
  String? type;
  List<InteractionOptions>? interactionOptions;
  List<String>? wrongOptions;

  QuestionModel(
      {this.id,
      this.preInteraction,
      this.interactionModule,
      this.postInteraction,
      this.files,
      this.type,
      this.interactionOptions,
      this.wrongOptions});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['preInteraction'] != null) {
      preInteraction = <PreInteraction>[];
      json['preInteraction'].forEach((v) {
        preInteraction!.add(PreInteraction.fromJson(v));
      });
    }
    interactionModule = json['interactionModule'] != null
        ? InteractionModule.fromJson(json['interactionModule'])
        : null;
    if (json['postInteraction'] != null) {
      postInteraction = <PostInteraction>[];
      json['postInteraction'].forEach((v) {
        postInteraction!.add(PostInteraction.fromJson(v));
      });
    }
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    type = json['type'];
    if (json['interactionOptions'] != null) {
      interactionOptions = <InteractionOptions>[];
      json['interactionOptions'].forEach((v) {
        interactionOptions!.add(InteractionOptions.fromJson(v));
      });
    }
    wrongOptions = json['wrongOptions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (preInteraction != null) {
      data['preInteraction'] = preInteraction!.map((v) => v.toJson()).toList();
    }
    if (interactionModule != null) {
      data['interactionModule'] = interactionModule!.toJson();
    }
    if (postInteraction != null) {
      data['postInteraction'] =
          postInteraction!.map((v) => v.toJson()).toList();
    }
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    if (interactionOptions != null) {
      data['interactionOptions'] =
          interactionOptions!.map((v) => v.toJson()).toList();
    }
    data['wrongOptions'] = wrongOptions;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{ id: $id, preInteraction: $preInteraction, interactionModule: $interactionModule, postInteraction: $postInteraction, files: $files, type: $type, interactionOptions: $interactionOptions,  wrongOptions: $wrongOptions }';
  }
}

class PreInteraction {
  String? text;
  String? type;
  int? order;
  String? id;
  String? visiableIf;

  PreInteraction({this.text, this.type, this.order, this.id, this.visiableIf});

  PreInteraction.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    type = json['type'];
    order = json['order'];
    id = json['id'];
    visiableIf = json['visiableIf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = text;
    data['type'] = type;
    data['order'] = order;
    data['id'] = id;
    data['visiableIf'] = visiableIf;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{ text: $text, type: $type, order: $order, id: $id, $visiableIf }';
  }
}

class PostInteraction {
  String? text;
  String? type;
  int? order;
  String? id;
  String? visiableIf;

  PostInteraction({this.text, this.type, this.order, this.id, this.visiableIf});

  PostInteraction.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    type = json['type'];
    order = json['order'];
    id = json['id'];
    visiableIf = json['visiableIf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = text;
    data['type'] = type;
    data['order'] = order;
    data['id'] = id;
    data['visiableIf'] = visiableIf;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{ text: $text, type: $type, order: $order, id: $id, visiableIf: $visiableIf }';
  }
}

class InteractionModule {
  List<Files>? files;
  String? type;
  List<InteractionOptions>? interactionOptions;
  List<String>? wrongOptions;

  InteractionModule(
      {this.files, this.type, this.interactionOptions, this.wrongOptions});

  InteractionModule.fromJson(Map<String, dynamic> json) {
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(Files.fromJson(v));
      });
    }
    type = json['type'];
    if (json['interactionOptions'] != null) {
      interactionOptions = <InteractionOptions>[];
      json['interactionOptions'].forEach((v) {
        interactionOptions!.add(InteractionOptions.fromJson(v));
      });
    }
    wrongOptions = json['wrongOptions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (files != null) {
      data['files'] = files!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    if (interactionOptions != null) {
      data['interactionOptions'] =
          interactionOptions!.map((v) => v.toJson()).toList();
    }
    data['wrongOptions'] = wrongOptions;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{ files: $files, type: $type, interactionOptions: $interactionOptions, wrongOptions: $wrongOptions }';
  }
}

class Files {
  String? codeLanguage;
  bool? isInteractive;
  String? content;
  String? name;

  Files({this.codeLanguage, this.isInteractive, this.content, this.name});

  Files.fromJson(Map<String, dynamic> json) {
    codeLanguage = json['codeLanguage'];
    isInteractive = json['isInteractive'];
    content = json['content'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['codeLanguage'] = codeLanguage;
    data['isInteractive'] = isInteractive;
    data['content'] = content;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{ codeLanguage: $codeLanguage, isInteractive: $isInteractive, content: $content, name: $name }';
  }
}

class InteractionOptions {
  TextObject? text;
  bool? correctOption;

  InteractionOptions({this.text, this.correctOption});

  InteractionOptions.fromJson(Map<String, dynamic> json) {
    text = json['text'] != null ? TextObject.fromJson(json['text']) : null;
    correctOption = json['correctOption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (text != null) {
      data['text'] = text!.toJson();
    }
    data['correctOption'] = correctOption;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{ text: $text, correctOption: $correctOption }';
  }
}

class TextObject {
  int? position;
  int? start;
  int? end;
  int? length;
  String? text;

  TextObject({this.position, this.start, this.end, this.length, this.text});

  TextObject.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    start = json['start'];
    end = json['end'];
    length = json['length'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['position'] = position;
    data['start'] = start;
    data['end'] = end;
    data['length'] = length;
    data['text'] = text;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '{ position: $position, text: $text  }';
  }
}
