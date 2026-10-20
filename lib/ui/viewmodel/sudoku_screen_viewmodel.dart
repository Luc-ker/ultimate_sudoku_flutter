import 'package:material_ui/material_ui.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:ultimate_sudoku_flutter/ui/viewmodel/sudoku_screen_state.dart';

class SudokuScreenViewModel extends ChangeNotifier {
  var state = SudokuScreenState.loading(Puzzle(PuzzleOptions()));

  Future<void> generatePuzzle() async {
    final currentState = state;

    if (currentState is SudokuScreenStateLoading) {
      await currentState.sudoku.generate();
      state = SudokuScreenState.sudoku(currentState.sudoku);
      notifyListeners();
    }
  }
}
