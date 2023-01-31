import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flimon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Simon game for Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyGameState();
}

class _MyGameState extends State<MyHomePage> {
  List<int> colors_game = [];
  List<int> colors_user = [];
  int playCount = 0;
  int maxPlayCount = 4;
  int greenShade = 500;
  int redShade = 500;
  int blueShade = 500;
  int yellowShade = 500;

  final TextStyle _textStyleDefault = const TextStyle(
    color: Colors.white,
  );

  void _start() {
    setState(() {
      if (playCount == maxPlayCount) {
        playCount = 0;
        maxPlayCount++;
        greenShade = 500;
        blueShade = 500;
        redShade = 500;
        yellowShade = 500;
      } else {
        int random = Random().nextInt(4);
        colors_game.add(random);
        switch (random) {
          case 0:
            greenShade = 900;
            blueShade = 500;
            redShade = 500;
            yellowShade = 500;
            break;
          case 1:
            greenShade = 500;
            blueShade = 900;
            redShade = 500;
            yellowShade = 500;
            break;
          case 2:
            greenShade = 500;
            blueShade = 500;
            redShade = 900;
            yellowShade = 500;
            break;
          case 3:
            greenShade = 500;
            blueShade = 500;
            redShade = 500;
            yellowShade = 900;
            break;
        }
        //sleep(const Duration(seconds: 1));
        playCount++;
        //_start();
      }
      print("0green 1blue 2red 3yellow $colors_game $playCount $maxPlayCount");
    });
  }

  void _checkWin() {
    if (colors_user.length == colors_game.length) {
      for (int i = 0; i < colors_user.length; i++) {
        if (colors_user[i] != colors_game[i]) {
          print("wrong");
          break;
        }
      }
      print("right");
    }
  }

  void _redPush() {
    setState(() {
      greenShade = 500;
      blueShade = 500;
      redShade = 900;
      yellowShade = 500;
      colors_user.add(2);
      _checkWin();
      print("redPush");
    });
  }

  void _bluePush() {
    setState(() {
      greenShade = 500;
      blueShade = 900;
      redShade = 500;
      yellowShade = 500;
      colors_user.add(1);
      _checkWin();
      print("bluePush");
    });
  }

  void _greenPush() {
    setState(() {
      greenShade = 900;
      blueShade = 500;
      redShade = 500;
      yellowShade = 500;
      colors_user.add(0);
      _checkWin();
      print("greenPush");
    });
  }

  void _yellowPush() {
    setState(() {
      greenShade = 500;
      blueShade = 500;
      redShade = 500;
      yellowShade = 900;
      colors_user.add(3);
      _checkWin();
      print("yellowPush");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
              GestureDetector(
                  onTap: () {
                    _redPush();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                        color: Colors.red[redShade],
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 20.0,
                              spreadRadius: .0,
                              offset: Offset(0, 15))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Text(
                          'Red button',
                          style: _textStyleDefault,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                      ],
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  _bluePush();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.blue[blueShade],
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                            spreadRadius: .0,
                            offset: Offset(0, 15))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        'Blue button',
                        style: _textStyleDefault,
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _greenPush();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.green[greenShade],
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                            spreadRadius: .0,
                            offset: Offset(0, 15))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        'Green button',
                        style: _textStyleDefault,
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _yellowPush();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      color: Colors.yellow[yellowShade],
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                            spreadRadius: .0,
                            offset: Offset(0, 15))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        'Yellow button',
                        style: _textStyleDefault,
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                    ],
                  ),
                ),
              ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _start,
        tooltip: 'Start game',
        child: const Icon(Icons.restart_alt),
      ),
    );
  }
}
