import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museu_vivo/app/modules/pages/store/store_bloc.dart';
import 'package:museu_vivo/app/modules/shared/models/item.dart';
import 'package:museu_vivo/app/modules/shared/models/user.dart';
import 'package:video_player/video_player.dart';

class ItemStore extends StatefulWidget {
  final Item item;

  ItemStore({this.item});

  @override
  _ItemStoreState createState() => _ItemStoreState();
}

class _ItemStoreState extends State<ItemStore> {
  final StoreBloc storeBloc = BlocProvider.getBloc<StoreBloc>();

  bool showMoreDetails = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(0, 2),
                blurRadius: 5,
              ),
            ]),
        child: Column(
          children: <Widget>[
            firstMedia(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.item.name,
                    style: TextStyle(
                        color: Color(0xFF50555C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.item.description ?? '',
                    style: TextStyle(
                      color: Color(0xFF50555C),
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: showMoreDetails ? 100 : 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showMoreDetails = !showMoreDetails;
                              });
                            },
                            child: Text(
                              showMoreDetails
                                  ? '< Menos detalhes'
                                  : 'Mais detalhes >',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFFAFAFAF),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          if (widget.item.isCreatedByMission)
                            Text(
                              "INVESTIMENTOS: ${widget.item.quantity}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                            )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/leratos/coins.svg',
                              ),
                              Text('  ${widget.item.value}'),
                            ],
                          ),
                          SizedBox(height: 5),
                          SizedBox(
                            height: 25,
                            child: StreamBuilder<User>(
                                stream: storeBloc.user,
                                builder: (context, snapshot) {
                                  return MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    color: widget.item.purchased
                                        ? Colors.grey
                                        : Color(0xff1fce27),
                                    child: Text(
                                      widget.item.purchased
                                          ? "OBTIDO"
                                          : "INVESTIR",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    onPressed: widget.item.purchased
                                        ? () {}
                                        : () {
                                            buyItem(context, storeBloc,
                                                widget.item, snapshot.data);
                                          },
                                  );
                                }),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buyItem(
      BuildContext context, StoreBloc storeBloc, Item item, User user) async {
    String successMessage = "Investimento realizado com sucesso.";
    String failedMessage =
        "Você não possui pontos suficientes para investir na obra.";
    print("Recursos do usuário: ${user.resources}");

    // Se o item não foi comprado e a compra deu sucesso...
    if (user.resources < item.value) {
      _customSnackBar(context, failedMessage, color: Colors.red);
    } else if (item.user == user.id) {
      _customSnackBar(context, "Você é o dono da obra.", color: Colors.orange);
    } else {
      try {
        await storeBloc.createItemOrder(item.id);
        _customSnackBar(context, successMessage, color: Colors.green);
      } catch (e) {
        _customSnackBar(context, "Algo deu errado.", color: Colors.red);
      }
    }
  }

  void _customSnackBar(BuildContext context, String message, {Color color}) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Icon(Icons.error),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: color,
      ),
    );
  }

  Widget firstMedia() {
    if (widget.item.has_video) {
      final ChewieController _chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.network(widget.item.video),
        aspectRatio: 16 / 9,
        autoInitialize: true,
        looping: false,
        errorBuilder: (_, __) => Text("Erro ao carregar o vídeo"),
      );

      return SizedBox(
        height: 180,
        child: Chewie(controller: _chewieController),
      );
    }

    if (widget.item.has_image || widget.item.image != null) {
      return Image.network(
        widget.item.image,
        height: 180,
      );
    }

    if (widget.item.has_audio) {
      ChewieAudioController _chewieAudioController = ChewieAudioController(
        videoPlayerController: VideoPlayerController.network(widget.item.audio),
        autoPlay: false,
        looping: false,
        autoInitialize: true,
      );
      return SizedBox(
        height: 80,
        child: ChewieAudio(controller: _chewieAudioController),
      );
    }

    if (widget.item.has_text || widget.item.text != null) {
      return SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Text(
              widget.item.text,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'BadScript',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return Container();
  }
}
