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
};

final Config config = _preConfigured['meuVivoMuseu'];
