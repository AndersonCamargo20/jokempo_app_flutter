import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JokenPo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'JokenPo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static var imagePrincipal = 'images/padrao.png';
  static var message = '';
  static var userChoice = 0;

  var options = {
    0: 'images/pedra.png',
    1: 'images/tesoura.png',
    2: 'images/papel.png',
  };

  bool gameRules(user, machine){
    if(user == 0 && machine == 2){
      return false;
    }else if(user == 1 && machine == 0){
        return false;
    }else if(user == 2 && machine == 1){
      return false;
    }
    return true;
  }
  
  setGame(){
    var op = Random().nextInt(3);
    var msg = 'Empate';
    if(op != userChoice){
      bool result = gameRules(userChoice, op);
      if(result){
        msg = 'Você ganhou o jogo';
      }else{
        msg = 'Você perdeu o jogo';
      }
    }

    setState(() {
      message = msg;
      imagePrincipal = options[op];
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double imagesHeight = width * 0.30;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('Escolha do App'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Image.asset(imagePrincipal, height: 120),
              ),
            ],
          ),
           Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(message),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    setState(() {
                      userChoice = 2;
                    });
                    this.setGame();
                  },
                  child: Image.asset('images/papel.png', height: imagesHeight),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      userChoice = 1;
                    });
                    this.setGame();
                  },
                  child: Image.asset('images/tesoura.png', height: imagesHeight),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      userChoice = 0;
                    });
                    this.setGame();
                  },
                  child: Image.asset('images/pedra.png', height: imagesHeight),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
