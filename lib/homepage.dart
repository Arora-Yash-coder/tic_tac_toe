import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Stores data of the Grid
  List<String> displayXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  // Stores total moves in a single match
  int count = 0;
  // Stores score of playerO
  int scoreO = 0;
  // Stores score of playerX
  int scoreX = 0;

  // TAP handler for the grid
  void tapped(int index) {
    setState(
      () {
        if (count % 2 == 0 && displayXO[index] == '') {
          displayXO[index] = '0';
          count++;
        } else {
          if (displayXO[index] == '') {
            displayXO[index] = 'X';
            count++;
          }
        }
        checkWinner();
      },
    );
  }

  // Checks the state of the current running game
  void checkWinner() {
    // checks 1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      showWinDailog(displayXO[0]);
    } else

    // checks 2nd row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      showWinDailog(displayXO[3]);
    } else

    // checks 3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      showWinDailog(displayXO[6]);
    } else

    // checks 1st column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      showWinDailog(displayXO[0]);
    } else

    // checks 2nd column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      showWinDailog(displayXO[1]);
    } else

    // checks 3rd column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      showWinDailog(displayXO[2]);
    } else

    // checks diagonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      showWinDailog(displayXO[6]);
    } else

    // checks diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      showWinDailog(displayXO[0]);
    } else if (count == 9) {
      showDrawDailog();
    }
  }

  // Shows a dialog if a player wins
  void showWinDailog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade700,
          title: Center(
            child: Text(
              'Winner is ' + winner,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
                onPressed: () {
                  resetGame();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Play Again',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        );
      },
    );
    if (winner == '0') {
      scoreO++;
    } else if (winner == 'X') {
      scoreX++;
    }
  }

  // Shows a dialog if current game is a draw
  void showDrawDailog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade700,
          title: const Center(
            child: Text(
              'Its a Draw',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
                onPressed: () {
                  resetGame();
                  Navigator.of(context).pop();
                },
                child: const Text('Play Again'))
          ],
        );
      },
    );
  }

  // resets the board
  void resetGame() {
    setState(() {
      for (var i = 0; i < displayXO.length; i++) {
        displayXO[i] = '';
      }
    });
    count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Player O',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        scoreO.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 3,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Player X',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        scoreX.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: const <Widget>[
                  Text(
                    'TIC TAC TOE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 3,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    '@CREATEDBYYASH',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
