import 'dart:convert';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/shared/models/mission.dart';
import 'package:museu_vivo/shared/repositories/mission_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MissionSubmitBloc extends BlocBase {
  final MissionRepository _missionRepository;
  final BehaviorSubject<String> _textAnswerController =
      BehaviorSubject<String>();
  final BehaviorSubject<File> _imageAnswerController = BehaviorSubject<File>();

  MissionSubmitBloc(this._missionRepository);

  Function(String) get changeTextAnswer => _textAnswerController.sink.add;
  Function(File) get changeImageAnswer => _imageAnswerController.sink.add;
  Observable<String> get textAnswer => _textAnswerController.stream;
  Observable<File> get imageAnswer => _imageAnswerController.stream;

  Future createMissionAnswer(Mission mission) async {
    if (mission.hasImage && _imageAnswerController.value == null ||
        mission.hasText && _textAnswerController.value == null)
      throw "Preencha todos os campos!";
    // || mission.isGrupal && _groupId == null

    return _missionRepository.createMissionAnswer(mission.id, {
      if (mission.hasText) 'text_msg': _textAnswerController.value,
      if (mission.hasImage)
        'image': await _changeFormatImage(_imageAnswerController.value),
      // if (widget._currentMission.isGrupal) '_group': int.parse(_groupId),
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
    super.dispose();
  }
}
