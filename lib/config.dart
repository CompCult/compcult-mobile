import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Config {
  final String name;
  final String apiUrl;
  final String assetsDirectoryName;
  final String coinName;
  final Color primaryColor;
  final Color accentColor;

  Config({
    this.name,
    this.apiUrl,
    this.assetsDirectoryName,
    this.coinName,
    this.primaryColor,
    this.accentColor,
  });
}

final Map<String, Config> _preConfigured = {
  'meuVivoMuseu': Config(
    name: 'Meu Vivo Museu',
    apiUrl: 'https://museu-vivo-api.herokuapp.com',
    assetsDirectoryName: 'meu_vivo_museu',
    coinName: 'Cults',
    primaryColor: Colors.red,
    accentColor: Colors.red,
  ),
  'soloAmigo': Config(
    name: 'Solo Amigo',
    apiUrl: 'https://solo-amigo.herokuapp.com',
    assetsDirectoryName: 'solo_amigo',
    coinName: 'Cults',
    primaryColor: Color(0xff5e3003),
    accentColor: Color(0xffce6b01),
  ),
};

final Config config = _preConfigured['meuVivoMuseu'];
