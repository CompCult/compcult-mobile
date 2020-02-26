import 'dart:async';
import 'dart:io' as io;

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:geolocator/geolocator.dart';

import 'package:museu_vivo/shared/components/custom_appbar.dart';

import 'package:museu_vivo/shared/models/group.dart';
import 'package:museu_vivo/shared/models/mission.dart';
import 'package:museu_vivo/shared/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'bloc/mission_submit_bloc.dart';

class MissionSubmit extends StatefulWidget {
  static const String routeName = '/mission-submit';
  final Mission mission;

  MissionSubmit(this.mission);

  @override
  _MissionSubmitState createState() => _MissionSubmitState();
}

class _MissionSubmitState extends State<MissionSubmit> {
  bool _isLoading = false;
  Position _currentPosition;
  FlutterAudioRecorder _recorder;
  AudioPlayer player;
  AudioCache audioCache;
  Recording _recording;
  Timer _timer;
  String _textRecordButton = "Gravar áudio";

  @override
  void initState() {
    super.initState();

    initPlayer();

    Future.microtask(() {
      _prepare();
    });


  }

  // ==================================================
  // ***** Métodos relacionados ao gravador de voz *****
  // ==================================================

  void initPlayer() {
    player = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: player);
  }

  Future _prepare() async {
    var hasPermission = await FlutterAudioRecorder.hasPermissions;

    if (hasPermission) {
      await _init();
      var result = await _recorder.current();

      setState(() {
        _recording = result;
        _textRecordButton = _playerTextButton(_recording.status);
      });
    }
  }

  Future _init() async {
    String customPath = '/flutter_audio_recorder_';
    io.Directory appDocDirectory;
    if (io.Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = await getExternalStorageDirectory();
    }

    // can add extension like ".mp4" ".wav" ".m4a" ".aac"
    customPath = appDocDirectory.path +
        customPath +
        DateTime.now().millisecondsSinceEpoch.toString();

    // .wav <---> AudioFormat.WAV
    // .mp4 .m4a .aac <---> AudioFormat.AAC
    // AudioFormat is optional, if given value, 
    // will overwrite path extension when there is conflicts.

    _recorder = FlutterAudioRecorder(customPath,
        audioFormat: AudioFormat.WAV, sampleRate: 22050);
    await _recorder.initialized;
  }

  void _recorderOptions() async {
    switch (_recording.status) {
      case RecordingStatus.Initialized:
        {
          await _startRecording();
          break;
        }
      case RecordingStatus.Recording:
        {
          await _stopRecording();
          break;
        }
      case RecordingStatus.Stopped:
        {
          await _prepare();
          break;
        }
      default:
        break;
    }

    setState(() {
      _textRecordButton = _playerTextButton(_recording.status);
    });
  }

  String _playerTextButton(RecordingStatus status) {
    switch (status) {
      case RecordingStatus.Initialized:
        {
          return "Gravar áudio";
        }
      case RecordingStatus.Recording:
        {
          return "Parar gravação";
        }
      case RecordingStatus.Stopped:
        {
          return "Regravar";
        }
      default:
        return "Gravação indisponível";
    }
  }

  Future _startRecording() async {
    await _recorder.start();
    var current = await _recorder.current();
    setState(() {
      _recording = current;
    });

    _timer = Timer.periodic(Duration(milliseconds: 10), (Timer timer) async {
      var current = await _recorder.current();
      setState(() {
        _recording = current;
        _timer = timer;
      });
    });
  }

  Future _stopRecording() async {
    var result = await _recorder.stop();
    _timer.cancel();
    io.File(_recording.path);

    setState(() {
      _recording = result;
    });
  }

  void _play() {
    player.play(_recording.path, isLocal: true);
  }

  void _pause() {
    player.pause();
  }

  void _stop() {
    player.stop();
  }

  Widget _buildRecordButton(MissionSubmitBloc bloc) {
    return FlatButton(
      color: Theme.of(context).accentColor,
      child: Text(
        _textRecordButton,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: _recorderOptions,
    );
  }

  Widget _buildRecorderButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          color: Theme.of(context).accentColor,
          child: Text('Play', style: TextStyle(color: Colors.white)),
          disabledTextColor: Colors.white,
          disabledColor: Colors.grey.withOpacity(0.5),
          onPressed:
              _recording?.status == RecordingStatus.Stopped ? _play : null,
        ),
        RaisedButton(
          color: Theme.of(context).accentColor,
          child: Text('Pause', style: TextStyle(color: Colors.white)),
          disabledTextColor: Colors.white,
          disabledColor: Colors.grey.withOpacity(0.5),
          onPressed:
              _recording?.status == RecordingStatus.Stopped ? _pause : null,
        ),
        RaisedButton(
          color: Theme.of(context).accentColor,
          child: Text('Stop', style: TextStyle(color: Colors.white)),
          disabledTextColor: Colors.white,
          disabledColor: Colors.grey.withOpacity(0.5),
          onPressed:
              _recording?.status == RecordingStatus.Stopped ? _stop : null,
        ),
      ],
    );
  }

  // ==================================================
  // ***** Métodos relacionados a geolocalização *****
  // ==================================================

  Widget _buildLocationLabel(String label, Color color) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(fontSize: 11, color: color),
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  }

  Widget _buildLocationButton(String value, MissionSubmitBloc bloc) {
    return FlatButton(
      color: Theme.of(context).accentColor,
      child: Text(
        value,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        _getCurrentLocation(bloc);
      },
    );
  }

  _getCurrentLocation(MissionSubmitBloc bloc) {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      bloc.changePositionAnswer(position);
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Widget _buildLocationValidator(MissionSubmitBloc missionSubmitBloc) {
    return _currentPosition != null
        ? Text(
            "Localização: ${_currentPosition.toString()}",
            style: TextStyle(
              color: Colors.green,
            ),
          )
        : Text(
            "Localização não encontrada. Verifique seu GPS.",
            style: TextStyle(
              color: Colors.red,
            ),
          );
  }

  // ==================================================
  // ***** Métodos relacionados ao envio em grupo *****
  // ==================================================

  Widget _buildTeamField(MissionSubmitBloc bloc) {
    return StreamBuilder<User>(
        stream: bloc.user,
        builder: (_, userSnapshot) {
          if (!userSnapshot.hasData) return Container();
          return FutureBuilder(
            future: _getGroups(userSnapshot.data.id),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return Container();

              final Response response = snapshot.data;

              final List<Group> groups = List<Group>.from(
                  response.data.map((group) => Group.fromJson(group)));

              var items = groups.map((Group group) {
                return DropdownMenuItem<String>(
                  value: group.id.toString(),
                  child: Text(group.name),
                );
              }).toList();

              return StreamBuilder<String>(
                  stream: bloc.groupAnswer,
                  builder: (context, groupSnapshot) {
                    return DropdownButton<String>(
                      hint: Text('Selecione um grupo'),
                      items: items,
                      onChanged: (value) => bloc.changeGroup(int.parse(value)),
                      value: groupSnapshot.data,
                    );
                  });
            },
          );
        });
  }
  // ==================================================
  // ***** Métodos relacionados ao envio de imagens *****
  // ==================================================

  Widget _buildImageValidator(MissionSubmitBloc missionSubmitBloc) {
    return StreamBuilder(
        stream: missionSubmitBloc.imageAnswer,
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Text(
                  "Nenhuma imagem selecionada...",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.red,
                  ),
                )
              : Text(
                  "Imagem carregada!",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                );
        });
  }

  Widget _buildImageField(MissionSubmitBloc missionSubmitBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _flatButtonIcon("Câmera", Icons.add_a_photo,
            () => _getImageFromCamera(missionSubmitBloc)),
        _flatButtonIcon("Galeria", Icons.wallpaper,
            () => _getImageFromGallery(missionSubmitBloc)),
      ],
    );
  }

  Future _getImageFromCamera(MissionSubmitBloc bloc) async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    bloc.changeImageAnswer(image);
  }

  Future _getImageFromGallery(MissionSubmitBloc bloc) async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    bloc.changeImageAnswer(image);
  }

  // ==================================================
  // ***** Métodos relacionados ao envio de texto *****
  // ==================================================

  Widget _buildTextField(MissionSubmitBloc missionSubmitBloc) {
    return StreamBuilder<String>(
        stream: missionSubmitBloc.textAnswer,
        builder: (context, snapshot) {
          return TextField(
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            onChanged: missionSubmitBloc.changeTextAnswer,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: "Resposta",
              labelStyle: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              hintText: "Insira um texto...",
              hintStyle: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              border: OutlineInputBorder(),
            ),
          );
        });
  }

  // ***** Métodos relacionados ao corpo da missão *****

  Widget _buildDescription(
      MissionSubmitBloc missionSubmitBloc, Mission mission) {
    return Text(
      mission.description,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "SourceSansPro",
        fontSize: 16,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildTitle(MissionSubmitBloc missionSubmitBloc, Mission mission) {
    return Text(
      mission.name,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontSize: 16,
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String label, MissionSubmitBloc bloc) {
    return Container(
      height: 50,
      color: Theme.of(context).accentColor,
      child: SizedBox.expand(
        child: FlatButton(
          child: _isLoading
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : Text(
                  label,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
          onPressed: () async {
            setState(() {
              _isLoading = true;
            });

            try {
              // Envio de áudio
              await bloc.changeAudioAnswer(io.File(_recording.path));
              await bloc.createMissionAnswer(widget.mission);
              Navigator.of(context).pop(true);
            } catch (e) {
              setState(() {
                _isLoading = false;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _flatButtonIcon(String label, IconData icon, Function func) {
    return FlatButton.icon(
      padding: EdgeInsets.only(left: 10, right: 10),
      onPressed: func,
      icon: Icon(icon),
      label: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  Future<dynamic> _getGroups(String userId) async {
    final Dio dio = Provider.of<Dio>(context);
    Response response = await dio.get('/group_members/groups?_user=$userId');

    return response;
  }

  @override
  Widget build(BuildContext context) {
    final MissionSubmitBloc missionSubmitBloc =
        BlocProvider.getBloc<MissionSubmitBloc>();

    return Scaffold(
      appBar: AppBar(
        title: CustomAppBar(),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildTitle(missionSubmitBloc, widget.mission),
              SizedBox(
                height: 20,
              ),
              _buildDescription(missionSubmitBloc, widget.mission),
              SizedBox(
                height: 15,
              ),
              if (widget.mission.isGrupal) _buildTeamField(missionSubmitBloc),
              SizedBox(
                height: 10,
              ),
              if (widget.mission.hasGeolocation)
                _buildLocationLabel("* Requer localização", Colors.red),
              if (widget.mission.hasText) _buildTextField(missionSubmitBloc),
              if (widget.mission.hasImage) _buildImageField(missionSubmitBloc),
              const SizedBox(height: 20),
              if (widget.mission.hasImage)
                _buildImageValidator(missionSubmitBloc),
              const SizedBox(height: 5),
              if (widget.mission.hasGeolocation)
                _buildLocationButton(
                    "Certifique-se que seu GPS está habilitado e clique aqui",
                    missionSubmitBloc),
              const SizedBox(height: 5),
              if (widget.mission.hasGeolocation)
                _buildLocationValidator(missionSubmitBloc),
              if (widget.mission.hasAudio)
                _buildRecordButton(missionSubmitBloc),
              const SizedBox(height: 10),
              if (widget.mission.hasAudio) _buildRecorderButtons(),
              const SizedBox(height: 80),
            ],
          ),
        ],
      ),
      bottomSheet: _buildButton(context, "ENVIAR RESPOSTA", missionSubmitBloc),
    );
  }
}
