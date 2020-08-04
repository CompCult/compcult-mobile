import 'dart:convert';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:museu_vivo/app/modules/shared/models/mission.dart';
import 'package:museu_vivo/app/modules/shared/models/user.dart';
import 'package:museu_vivo/app/modules/shared/repositories/mission_repository.dart';
import 'package:museu_vivo/app/modules/shared/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MissionSubmitBloc extends BlocBase {
  final MissionRepository _missionRepository;
  final UserRepository _userRepository;
  final BehaviorSubject<String> _textAnswerController =
      BehaviorSubject<String>();
  final BehaviorSubject<int> _groupController = BehaviorSubject<int>();
  final BehaviorSubject<File> _videoAnswerController = BehaviorSubject<File>();
  final BehaviorSubject<File> _imageAnswerController = BehaviorSubject<File>();
  final BehaviorSubject<File> _audioAnswerController = BehaviorSubject<File>();
  final BehaviorSubject<Position> _locationController =
      BehaviorSubject<Position>();
  final BehaviorSubject<String> _itemTitleController =
      BehaviorSubject<String>();
  final BehaviorSubject<int> _itemValueController = BehaviorSubject<int>();

  MissionSubmitBloc(this._missionRepository, this._userRepository);

  Function(String) get changeTextAnswer => _textAnswerController.sink.add;
  Function(int) get changeGroup => _groupController.sink.add;
  Function(File) get changeImageAnswer => _imageAnswerController.sink.add;
  Function(File) get changeVideoAnswer => _videoAnswerController.sink.add;
  Function(Position) get changePositionAnswer => _locationController.sink.add;
  Function(File) get changeAudioAnswer => _audioAnswerController.sink.add;
  Function(String) get changeItemTitleAnswer => _itemTitleController.sink.add;
  Function(int) get changeItemValueAnswer => _itemValueController.sink.add;

  Observable<User> get user => _userRepository.user;
  Observable<String> get textAnswer => _textAnswerController.stream;
  Observable<String> get groupAnswer => _groupController.stream
      .map((group) => group != null ? group.toString() : null);
  Observable<File> get imageAnswer => _imageAnswerController.stream;
  Observable<File> get videoAnswer => _videoAnswerController.stream;
  Observable<File> get audioAnswer => _audioAnswerController.stream;
  Observable<Position> get positionAnswer => _locationController.stream;
  Observable<String> get itemTitleAnswer => _itemTitleController.stream;
  Observable<int> get itemValueAnswer => _itemValueController.stream;

  Future createMissionAnswer(Mission mission) async {
    if (mission.hasImage && _imageAnswerController.value == null ||
        mission.hasVideo && _videoAnswerController.value == null ||
        mission.hasText && _textAnswerController.value == null ||
        mission.isGrupal && _groupController == null ||
        mission.hasGeolocation && _locationController == null ||
        mission.hasAudio && _audioAnswerController == null)
      throw "Preencha todos os campos!";

    return await _missionRepository.createMissionAnswer(mission.id, {
      if (mission.hasText) 'text_msg': _textAnswerController.value,
      if (mission.hasVideo)
        'video': await _changeFormatAudio(_videoAnswerController.value),
      if (mission.hasImage)
        'image': await _changeFormatImage(_imageAnswerController.value),
      if (mission.isGrupal) '_group': _groupController.value,
      if (mission.hasGeolocation)
        'location_lat': _locationController.value.latitude,
      if (mission.hasGeolocation)
        'location_lng': _locationController.value.longitude,
      if (mission.hasAudio)
        'audio': await _changeFormatAudio(_audioAnswerController.value),
      if (mission.isEntrepreneurial) 'title': _itemTitleController.value,
      if (mission.isEntrepreneurial) 'value': _itemValueController.value
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
    _videoAnswerController.close();
    _groupController.close();
    _locationController.close();
    _audioAnswerController.close();
    super.dispose();
  }
}
