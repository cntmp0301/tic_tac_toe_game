import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  int attempts = 0;
  List<int> matchedIndexes = [];

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool winnerFound = false;
  Timer? timer;
  static const maxSeconds = 30;
  int seconds = maxSeconds;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void _tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;

    if (isRunning) {
      setState(() {
        if (oTurn && displayXO[index] == '') {
          displayXO[index] = 'O';
          filledBoxes++;
        } else if (!oTurn && displayXO[index] == '') {
          displayXO[index] = 'X';
          filledBoxes++;
        }
        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  String result = '';
  void _checkWinner() {
    // row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        result = 'Player ${displayXO[0]} Wins!';
        matchedIndexes.addAll([0, 1, 2]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        result = 'Player ${displayXO[3]} Wins!';
        matchedIndexes.addAll([3, 4, 5]);
        stopTimer();
        _updateScore(displayXO[3]);
      });
    }
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        result = 'Player ${displayXO[6]} Wins!';
        matchedIndexes.addAll([6, 7, 8]);
        stopTimer();
        _updateScore(displayXO[6]);
      });
    }

    // column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        result = 'Player ${displayXO[0]} Wins!';
        matchedIndexes.addAll([0, 3, 6]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        result = 'Player ${displayXO[1]} Wins!';
        matchedIndexes.addAll([1, 4, 7]);
        stopTimer();
        _updateScore(displayXO[1]);
      });
    }
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        result = 'Player ${displayXO[2]} Wins!';
        matchedIndexes.addAll([2, 5, 8]);
        stopTimer();
        _updateScore(displayXO[2]);
      });
    }

    // diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        result = 'Player ${displayXO[0]} Wins!';
        matchedIndexes.addAll([0, 4, 8]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    } else if (!winnerFound && filledBoxes == 9) {
      setState(() {
        result = 'Nobody Wins!';
      });
    }
    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      setState(() {
        result = 'Player ${displayXO[2]} Wins!';
        matchedIndexes.addAll([2, 4, 6]);
        stopTimer();
        _updateScore(displayXO[2]);
      });
    } else if (!winnerFound && filledBoxes == 9) {
      setState(() {
        result = 'Nobody Wins!';
      });
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      result = '';
    });
    matchedIndexes = [];
    oScore = 0;
    xScore = 0;
    filledBoxes = 0;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _scoreBoard(
                scoreFonts: MainFont.scoreFonts,
                oScore: oScore,
                xScore: xScore),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 5,
                            color: MainColor.primaryColor,
                          ),
                          color: matchedIndexes.contains(index)
                              ? MainColor.accentColor
                              : MainColor.secondaryColor,
                        ),
                        child: Center(
                          child: Text(
                            displayXO[index],
                            style: GoogleFonts.silkscreen(
                              textStyle: TextStyle(
                                fontSize: 60,
                                color: MainColor.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(result, style: MainFont.customFonts),
                    const SizedBox(height: 40),
                    _buildTimer()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: MainColor.accentColor,
                ),
                Center(
                  child: Text(
                    '$seconds',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 45),
                  ),
                ),
              ],
            ),
          )
        : SizedBox(
            width: 100,
            height: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.zero,
                // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                startTimer();
                _clearBoard();
                attempts++;
              },
              child: Icon(
                attempts == 0 ? Icons.play_arrow : Icons.refresh,
                color: MainColor.primaryColor,
                size: 80,
              ),
              // child: Text(
              //   attempts == 0 ? 'Start' : 'Play Again!',
              //   style: TextStyle(fontSize: 20, color: Colors.black),
              // ),
            ),
          );
  }
}

class _scoreBoard extends StatelessWidget {
  const _scoreBoard({
    super.key,
    required this.scoreFonts,
    required this.oScore,
    required this.xScore,
  });

  final TextStyle scoreFonts;
  final int oScore;
  final int xScore;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Player O',
                  style: TextStyle(color: Colors.white),
                ),
                Text(oScore.toString(), style: scoreFonts),
              ],
            ),
            const SizedBox(width: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Player X',
                  style: TextStyle(color: Colors.white),
                ),
                Text(xScore.toString(), style: scoreFonts),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
