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
            _TitleButton(buttonText: 'Press to start!', loadPrevSudoku: false),
            _TitleButton(
              buttonText: 'Load previous sudoku',
              loadPrevSudoku: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleButton extends StatelessWidget {
  final String buttonText;
  final bool loadPrevSudoku;

  const _TitleButton({required this.buttonText, required this.loadPrevSudoku});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SudokuScreen(title: '', loadPrevSudoku: loadPrevSudoku),
          ),
        );
      },
      child: Text(buttonText),
    );
  }
}
