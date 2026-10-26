import 'package:material_ui/material_ui.dart';
import 'package:ultimate_sudoku_flutter/ui/sudoku/sudoku_screen.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('The Ultimate Sudoku App'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SudokuScreen(title: ''),
                  ),
                );
              },
              child: Text('Press to start!'),
            ),
          ],
        ),
      ),
    );
  }
}
