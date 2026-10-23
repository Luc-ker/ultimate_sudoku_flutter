import 'package:material_ui/material_ui.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:ultimate_sudoku_flutter/ui/sudoku/viewmodel/sudoku_screen_state.dart';

import '../../../models/fill_mode.dart';

class SudokuScreenViewModel extends ChangeNotifier {
  var state = SudokuScreenState.loading(sudoku: Puzzle(PuzzleOptions()));

  Future<void> generatePuzzle() async {
    final currentState = state;

    if (currentState is SudokuScreenStateLoading) {
      await currentState.sudoku.generate();
      state = SudokuScreenState.sudoku(sudoku: currentState.sudoku);
      notifyListeners();
    }
  }

  void selectFillNumber(int number) {
    final currentState = state;

    if (currentState is SudokuScreenStateSudoku) {
      state = currentState.copyWith(selectedNumber: number);
      notifyListeners();
    }
  }

  void switchFillMode(FillMode fillMode) {
    final currentState = state;

    if (currentState is SudokuScreenStateSudoku) {
      state = currentState.copyWith(fillMode: currentState.fillMode.other);
      notifyListeners();
    }
  }

  void fillCell(int index) {
    final currentState = state;

    if (currentState is SudokuScreenStateSudoku &&
        currentState.selectedNumber != 0) {
      if (currentState.solved) return;

      final sudoku = currentState.sudoku;
      final cellPos = Position(index: index);
      if (sudoku.wasCellPrefilled(cellPos)) return;

      final violations = sudoku.fillCell(cellPos, currentState.selectedNumber);
      state = currentState.copyWith(sudoku: sudoku);
      if (sudoku.isBoardFullyFilled() && violations.isEmpty) {
        state = currentState.copyWith(solved: true);
      }
      notifyListeners();
    }
  }
}

extension on Puzzle {
  bool wasCellPrefilled(Position pos) =>
      board()?.cellAt(pos).prefill() ?? false;

  bool isBoardFullyFilled() {
    final matrix = board()?.matrix();
    return (matrix != null)
        ? !matrix.any((row) => row.any((cell) => cell.getValue() == 0))
        : false;
  }
}
