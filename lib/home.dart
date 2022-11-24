import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _diceList = <String>[
    'images/dice1.png',
    'images/dice2.png',
    'images/dice3.png',
    'images/dice4.png',
    'images/dice5.png',
    'images/dice6.png',
  ];

  int _index1 = 0, _index2 = 0, _diceSum = 0, _point = 0;
  final _random = Random.secure();
  bool _hasGameStarted = false;
  bool _isGameOver = false;
  String _statusMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Mini Dice Game'),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        color: Colors.teal,
        alignment: Alignment.center,
        child: const Text(
          'EnoCodes',
          style: TextStyle(fontSize: 25.0),
        ),
      ),
      body: Center(
        child: _hasGameStarted ? _gameSection() : _startGameSection(),
      ),
    );
  }

  Widget _startGameSection() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _hasGameStarted = true;
        });
      },
      child: const Text('START'),
    );
  }

  Widget _gameSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _diceList[_index1],
              width: 100.0,
              height: 100.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Image.asset(
              _diceList[_index2],
              width: 100.0,
              height: 100.0,
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          height: 50.0,
          width: 200.0,
          child: ElevatedButton(
            onPressed: _isGameOver ? null : _rollTheDice,
            child: const Text('ROLL'),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          'Dice Sum: $_diceSum',
          style: const TextStyle(fontSize: 22.0),
        ),
        const SizedBox(
          height: 10.0,
        ),
        if (_point > 0)
          Text(
            'Your Point: $_point',
            style: TextStyle(
                fontSize: 22.0,
                color: Colors.blue[900],
                fontWeight: FontWeight.bold),
          ),
        const SizedBox(
          height: 10.0,
        ),
        if (_point > 0 && !_isGameOver)
          Text(
            'Keep rolling till you match the points $_point',
            style: const TextStyle(
                fontSize: 22.0, backgroundColor: Colors.redAccent),
          ),
        const SizedBox(
          height: 10.0,
        ),
        if (_isGameOver)
          Text(
            _statusMsg,
            style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        const SizedBox(
          height: 10.0,
        ),
        if (_isGameOver)
          SizedBox(
            height: 50.0,
            width: 200.0,
            child: ElevatedButton(
              onPressed: _resetGame,
              child: const Text('PLAY AGAIN'),
            ),
          )
      ],
    );
  }

  void _rollTheDice() {
    setState(() {
      _index1 = _random.nextInt(6);
      _index2 = _random.nextInt(6);
      _diceSum = _index1 + _index2 + 2;
      if (_point > 0) {
        _checkSecondThrow();
      } else {
        _checkFirstThrow();
      }
    });
  }

  void _checkFirstThrow() {
    switch (_diceSum) {
      case 7:
      case 11:
        _statusMsg = 'YOU WIN!!!';
        _isGameOver = true;
        break;
      case 2:
      case 3:
      case 12:
        _statusMsg = 'YOU LOST!!!';
        _isGameOver = true;
        break;
      default:
        _point = _diceSum;
        break;
    }
  }

  void _checkSecondThrow() {
    if (_diceSum == _point) {
      _statusMsg = 'YOU WIN!!!';
      _isGameOver = true;
    } else if (_diceSum == 7) {
      _statusMsg = 'YOU LOST!!!';
      _isGameOver = true;
    }
  }

  void _resetGame() {
    setState(() {
      _index1 = 0;
      _index2 = 0;
      _diceSum = 0;
      _point = 0;
      _isGameOver = false;
      _hasGameStarted = false;
    });
  }
}
