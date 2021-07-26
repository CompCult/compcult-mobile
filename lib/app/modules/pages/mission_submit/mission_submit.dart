import 'dart:async';
import 'dart:io' as io;

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:museu_vivo/app/modules/pages/teams/teams_page.dart';
import 'package:museu_vivo/app/modules/shared/components/custom_appbar.dart';
import 'package:museu_vivo/app/modules/shared/models/group.dart';
import 'package:museu_vivo/app/modules/shared/models/mission.dart';
import 'package:museu_vivo/app/modules/shared/models/user.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'mission_submit_bloc.dart';

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
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Color(0xff60B3FC),
        child: Text(
          _textRecordButton,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: _recorderOptions,
      ),
    );
  }

  Widget _buildRecorderButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,
          child: Icon(Icons.play_arrow, color: Colors.white),
          disabledTextColor: Colors.white,
          disabledColor: Color(0xff60B3FC),
          onPressed:
              _recording?.status == RecordingStatus.Stopped ? _play : null,
        ),
        SizedBox(width: 2),
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,
          child: Icon(
            Icons.pause,
            color: Colors.white,
          ),
          disabledTextColor: Colors.white,
          disabledColor: Color(0xff60B3FC),
          onPressed:
              _recording?.status == RecordingStatus.Stopped ? _pause : null,
        ),
        SizedBox(width: 2),
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Theme.of(context).accentColor,
          child: Icon(
            Icons.stop,
            color: Colors.white,
          ),
          disabledTextColor: Colors.white,
          disabledColor: Color(0xff60B3FC),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Color(0xff60B3FC),
      child: Text(
        value,
        style: TextStyle(color: Colors.white, fontSize: 11),
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

              Widget addGroupButton = MaterialButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(TeamsPage.routeName)
                    .then((_) => setState(() {})),
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'criar\ngrupo',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              );

              return StreamBuilder<String>(
                  stream: bloc.groupAnswer,
                  builder: (context, groupSnapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<String>(
                          hint: Text('Selecione um grupo'),
                          items: items,
                          onChanged: (value) =>
                              bloc.changeGroup(int.parse(value)),
                          value: groupSnapshot.data,
                        ),
                        SizedBox(width: 10),
                        addGroupButton
                      ],
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

  Widget _buildVideoValidator(MissionSubmitBloc missionSubmitBloc) {
    return StreamBuilder(
        stream: missionSubmitBloc.videoAnswer,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              "Nenhum video selecionado...",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.red,
              ),
            );
          }
          final ChewieController _chewieController = ChewieController(
            videoPlayerController: VideoPlayerController.file(snapshot.data),
            aspectRatio: 16 / 9,
            autoInitialize: true,
            looping: false,
            errorBuilder: (_, __) => Text("Erro ao carregar o vídeo"),
          );
          return Chewie(controller: _chewieController);
        });
  }

  Widget _buildVideoField(MissionSubmitBloc missionSubmitBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _flatButtonIcon("Camera", Icons.add_a_photo,
            () => _getVideoFromCamera(missionSubmitBloc)),
        _flatButtonIcon("Galeria", Icons.wallpaper,
            () => _getVideoFromGallery(missionSubmitBloc)),
      ],
    );
  }

  Widget _buildImageField(MissionSubmitBloc missionSubmitBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _flatButtonIcon("Camera", Icons.add_a_photo,
            () => _getImageFromCamera(missionSubmitBloc)),
        _flatButtonIcon("Galeria", Icons.wallpaper,
            () => _getImageFromGallery(missionSubmitBloc)),
      ],
    );
  }

  Future _getVideoFromCamera(MissionSubmitBloc bloc) async {
    final video = await ImagePicker.pickVideo(source: ImageSource.camera);
    bloc.changeVideoAnswer(video);
  }

  Future _getVideoFromGallery(MissionSubmitBloc bloc) async {
    final video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    bloc.changeVideoAnswer(video);
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        border: Border.all(color: Colors.blue),
      ),
      padding: EdgeInsets.all(10),
      child: Text(
        mission.description,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "SourceSansPro",
          fontSize: 16,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildTitle(MissionSubmitBloc missionSubmitBloc, Mission mission) {
    return Text(
      mission.name.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: "Roboto",
        fontWeight: FontWeight.bold,
        color: Color(0xFF50555C),
        fontSize: 18,
      ),
    );
  }

  Widget _buildItemPropertiens(MissionSubmitBloc missionSubmitBloc) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(
              'Se aprovado, sua resposta será transformada em uma obra exposta na feira, por favor preencha os campos:'),
          TextField(
            decoration: InputDecoration(
              labelText: "Titulo da obra",
              hintText: "ex: Poema contra violência",
              icon: Icon(Icons.text_fields),
            ),
            onChanged: missionSubmitBloc.changeItemTitleAnswer,
          ),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: "Valor da obra",
              hintText: "ex: 20",
              icon: SvgPicture.asset(
                'assets/leratos/coins.svg',
              ),
            ),
            onChanged: (value) =>
                missionSubmitBloc.changeItemValueAnswer(int.parse(value)),
          ),
        ],
      ),
    );
  }

  Widget _points() {
    return Row(
      children: <Widget>[
        Container(
          width: 17,
          height: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.green,
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Text('',
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 13,
            )),
        SizedBox(
          width: 7,
        ),
        SizedBox(
          width: 3,
        ),
        Text('',
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 13,
            )),
      ],
    );
  }

  Widget _buildButton(
      BuildContext context, String label, MissionSubmitBloc bloc) {
    return _isLoading
        ? CircularProgressIndicator(
            backgroundColor: Colors.white,
          )
        : FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Colors.blue,
            child: Container(
              height: 45,
              width: 150,
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
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
          );
  }

  Widget _flatButtonIcon(String label, IconData icon, Function func) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xff60B3FC)),
        child: Center(
          child: IconButton(
            icon: Icon(
              icon,
              size: 19,
              color: Colors.white,
            ),
            onPressed: func,
          ),
        ),
      ),
    );
    /*FlatButton.icon(
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
    );*/
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
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(0, 2),
                blurRadius: 5,
              ),
            ]),
        child: ListView(
          padding: const EdgeInsets.only(left: 15, right: 15),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      _buildTitle(missionSubmitBloc, widget.mission),
                      SizedBox(
                        height: 20,
                      ),
                      _buildDescription(missionSubmitBloc, widget.mission),
                      SizedBox(
                        height: 15,
                      ),
                      if (widget.mission.isGrupal)
                        _buildTeamField(missionSubmitBloc),
                      SizedBox(
                        height: 10,
                      ),
                      if (widget.mission.hasGeolocation)
                        _buildLocationLabel("* Requer localização", Colors.red),
                      if (widget.mission.hasText)
                        _buildTextField(missionSubmitBloc),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (widget.mission.hasGeolocation)
                            _buildLocationButton(
                                "Clique aqui para enviar sua posição",
                                missionSubmitBloc),
                          const SizedBox(height: 20),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          if (widget.mission.hasImage)
                            Column(
                              children: <Widget>[
                                Text("Envio de Imagem"),
                                _buildImageField(missionSubmitBloc),
                              ],
                            ),
                          if (widget.mission.hasVideo)
                            Column(
                              children: <Widget>[
                                Text("Envio de Vídeo"),
                                _buildVideoField(missionSubmitBloc),
                              ],
                            )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (widget.mission.hasImage)
                        _buildImageValidator(missionSubmitBloc),
                      if (widget.mission.hasVideo)
                        _buildVideoValidator(missionSubmitBloc),
                      const SizedBox(height: 5),
                      if (widget.mission.hasGeolocation)
                        _buildLocationValidator(missionSubmitBloc),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (widget.mission.hasAudio)
                            _buildRecordButton(missionSubmitBloc),
                          const SizedBox(height: 10),
                          if (widget.mission.hasAudio) _buildRecorderButtons(),
                          const SizedBox(height: 80),
                        ],
                      ),
                      if (widget.mission.isEntrepreneurial)
                        _buildItemPropertiens(missionSubmitBloc),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildButton(
                              context, "ENVIAR RESPOSTA", missionSubmitBloc),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
