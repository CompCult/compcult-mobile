import 'dart:convert';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/mission.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:museu_vivo/shared/repositories/mission_repository.dart';
import 'package:museu_vivo/shared/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MissionSubmitBloc extends BlocBase {
  final MissionRepository _missionRepository;
  final UserRepository _userRepository;
  final BehaviorSubject<String> _textAnswerController =
      BehaviorSubject<String>();
  final BehaviorSubject<int> _groupController = BehaviorSubject<int>();
  final BehaviorSubject<File> _imageAnswerController = BehaviorSubject<File>();

  MissionSubmitBloc(this._missionRepository, this._userRepository);

  Function(String) get changeTextAnswer => _textAnswerController.sink.add;
  Function(int) get changeGroup => _groupController.sink.add;
  Function(File) get changeImageAnswer => _imageAnswerController.sink.add;

  Observable<User> get user => _userRepository.user;
  Observable<String> get textAnswer => _textAnswerController.stream;
  Observable<String> get groupAnswer => _groupController.stream
      .map((group) => group != null ? group.toString() : null);
  Observable<File> get imageAnswer => _imageAnswerController.stream;

  Future createMissionAnswer(Mission mission) async {
    if (mission.hasImage && _imageAnswerController.value == null ||
        mission.hasText && _textAnswerController.value == null ||
        mission.isGrupal && _groupController == null)
      throw "Preencha todos os campos!";

    return _missionRepository.createMissionAnswer(mission.id, {
      if (mission.hasText) 'text_msg': _textAnswerController.value,
      if (mission.hasImage)
        'image': await _changeFormatImage(_imageAnswerController.value),
      if (mission.isGrupal) '_group': _groupController.value,
    });
  }

  Future<String> _changeFormatImage(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    return base64Encode(imageBytes);
  }

  @override
  void dispose() {
    _textAnswerController.close();
    _imageAnswerController.close();
    _groupController.close();
    super.dispose();
  }
}
