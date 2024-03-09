import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> superheroes = [];
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadSuperheroes();
    _playBackgroundMusic();
  }

  Future<void> _loadSuperheroes() async {
    String data = await rootBundle.loadString('json_assets/superheroes.json');
    setState(() {
      superheroes = json.decode(data);
    });
  }

  Future<void> _playBackgroundMusic() async {
    await audioPlayer.play(AssetSource('song.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AG9_Decodificado de Json: Marco Adrian'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: superheroes.length,
          itemBuilder: (BuildContext context, int index) {
            var superhero = superheroes[index];
            return Card(
              child: ListTile(
                leading: Image.asset(
                  superhero['imagen'],
                  width: 50.0,
                  height: 50.0,
                ),
                title: Text(superhero['nombre']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Identidad: ${superhero['identidad']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Descripción: ${superhero['descripcion']}',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
