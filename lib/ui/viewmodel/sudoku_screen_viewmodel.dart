import 'package:material_ui/material_ui.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:ultimate_sudoku_flutter/ui/viewmodel/sudoku_screen_state.dart';

class SudokuScreenViewModel extends ChangeNotifier {
  var state = SudokuScreenState.loading(Puzzle(PuzzleOptions()));

  Future<void> generatePuzzle() async {
    final currentState = state;

    if (currentState is SudokuScreenStateLoading) {
      await currentState.sudoku.generate();
      state = SudokuScreenState.sudoku(currentState.sudoku, 0, false);
      notifyListeners();
    }
  }

  void selectFillNumber(int number) {
    final currentState = state;

    if (currentState is SudokuScreenStateSudoku) {
      state = currentState.copyWith(fillNumber: number);
      notifyListeners();
    }
  }

  void fillCell(int index) {
    final currentState = state;

    if (currentState is SudokuScreenStateSudoku &&
        currentState.fillNumber != 0) {
      final sudoku = currentState.sudoku;
      final violations = sudoku.fillCell(
        Position(index: index),
        currentState.fillNumber,
      );
      state = currentState.copyWith(sudoku: sudoku);
      if (sudoku.isBoardFullyFilled() && violations.isEmpty) {
        state = currentState.copyWith(solved: true);
      }
      notifyListeners();
    }
  }
}

extension on Puzzle {
  bool isBoardFullyFilled() {
    final matrix = board()?.matrix();
    return (matrix != null) ?
      !matrix.any((row) => row.any((cell) => cell.getValue() == 0)) : false;
  }
}
