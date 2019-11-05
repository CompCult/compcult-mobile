## Compcult Mobile

Aplicativo de compartilhamento e aprendizado dinâmico através de atividades didáticas em mundo real e virtual.

### Build do apk

Antes de começar, certifique-se de:
 * ter criado a pasta com os assets do aplicativo (ex. assets/nome_do_app);
 * que os nomes das imagens do app seguem o padrão de nomeclatura (ex. assets/nome_do_app/logo.png)

Substitua **nome_do_app** pela nome da pasta do app em assets/ 

#### 1. lib/config.dart
Edite as configurações gerais do aplicativo na variável config

> final Config config = Config(...);

**Obs:** Alguns alplicativos já estão pré configurados, para usar a pré configuração faça:

> final Config config = _preConfigured['nomeDoAplicativo'];

#### 2. pubspec.yaml

Altere a logo na sessão **flutter_icons**
```
flutter_icons:
  android: true 
  ios: true
  image_path: "assets/nome_do_app/icon.png"
```
  
Altere a pasta de assets na sessão assets  
```
assets:
   - assets/
   - assets/nome_do_app/
```

#### 3. android/app/src/main/AndroidManifest.xml

Altere o nome do app
```
<application
        android:name="io.flutter.app.FlutterApplication"
        android:label="Nome do App"
        android:icon="@mipmap/ic_launcher">
...
```

#### 4. android/app/src/main/res/drawable/launch_img.png

Altere a imagem que ficará na splash screen

#### 5. Build do apk

Para geral o apk execute
> flutter packages pub run flutter_launcher_icons:main
  
> flutter build apk