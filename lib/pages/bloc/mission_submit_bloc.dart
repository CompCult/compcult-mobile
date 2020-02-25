import 'dart:convert';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:geolocator/geolocator.dart';
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
  final BehaviorSubject<File> _audioAnswerController = BehaviorSubject<File>();
  final BehaviorSubject<Position> _locationController =
      BehaviorSubject<Position>();

  MissionSubmitBloc(this._missionRepository, this._userRepository);

  Function(String) get changeTextAnswer => _textAnswerController.sink.add;
  Function(int) get changeGroup => _groupController.sink.add;
  Function(File) get changeImageAnswer => _imageAnswerController.sink.add;
  Function(Position) get changePositionAnswer => _locationController.sink.add;
  Function(File) get changeAudioAnswer => _audioAnswerController.sink.add;

  Observable<User> get user => _userRepository.user;
  Observable<String> get textAnswer => _textAnswerController.stream;
  Observable<String> get groupAnswer => _groupController.stream
      .map((group) => group != null ? group.toString() : null);
  Observable<File> get imageAnswer => _imageAnswerController.stream;
  Observable<File> get audioAnswer => _audioAnswerController.stream;
  Observable<Position> get positionAnswer => _locationController.stream;

  Future createMissionAnswer(Mission mission) async {
    if (mission.hasImage && _imageAnswerController.value == null ||
        mission.hasText && _textAnswerController.value == null ||
        mission.isGrupal && _groupController == null ||
        mission.hasGeolocation && _locationController == null ||
        mission.hasAudio && _audioAnswerController == null)
      throw "Preencha todos os campos!";

    return _missionRepository.createMissionAnswer(mission.id, {
      if (mission.hasText) 'text_msg': _textAnswerController.value,
      if (mission.hasImage)
        'image': await _changeFormatImage(_imageAnswerController.value),
      if (mission.isGrupal) '_group': _groupController.value,
      if (mission.hasGeolocation)
        'location_lat': _locationController.value.latitude,
      if (mission.hasGeolocation)
        'location_lng': _locationController.value.longitude,
      if (mission.hasAudio)
        'audio': await _changeFormatAudio(_audioAnswerController.value),
    });
  }

  Future<String> _changeFormatImage(File image) async {
    List<int> imageBytes = await image.readAsBytes();
    return base64Encode(imageBytes);
  }

  Future<String> _changeFormatAudio(File audio) async {
    List<int> audioBytes = await audio.readAsBytes();
    return base64Encode(audioBytes);
  }

  @override
  void dispose() {
    _textAnswerController.close();
    _imageAnswerController.close();
    _groupController.close();
    _locationController.close();
    _audioAnswerController.close();
    super.dispose();
  }
}
