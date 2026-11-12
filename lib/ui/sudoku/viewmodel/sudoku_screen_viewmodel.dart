import 'package:material_ui/material_ui.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:ultimate_sudoku_flutter/models/fill_mode.dart';
import 'package:ultimate_sudoku_flutter/ui/sudoku/viewmodel/sudoku_screen_state.dart';
import 'package:ultimate_sudoku_flutter/utils/cell_utils.dart';
import 'package:ultimate_sudoku_flutter/utils/puzzle_utils.dart';

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
      state = currentState.copyWith(fillNumber: number);
      notifyListeners();
    }
  }

  void switchFillMode(FillMode fillMode) {
    final currentState = state;

    if (currentState is SudokuScreenStateSudoku &&
        currentState.fillMode != fillMode) {
      state = currentState.copyWith(fillMode: currentState.fillMode.other);
      notifyListeners();
    }
  }

  void fillCell(int index) {
    final currentState = state;

    if (currentState is SudokuScreenStateSudoku &&
        currentState.fillNumber != 0) {
      final fillNum = currentState.fillNumber;
      if (currentState.solved) return;

      final sudoku = currentState.sudoku;
      final cellPos = Position(index: index);
      if (sudoku.wasCellPrefilled(cellPos)) return;

      final cell = sudoku.board()?.cellAt(cellPos);
      if (cell == null) return;

      if (fillNum == 10) {
        cell.hasValue() ? cell.setValue(0) : cell.clearMarkup();
      } else {
        switch (currentState.fillMode) {
          case FillMode.normal:
            final violations = sudoku.fillCell(cellPos, fillNum);
            if (sudoku.isBoardFullyFilled() && violations.isEmpty) {
              updateSudokuState(currentState, sudoku, solved: true);
              return;
            }
          case FillMode.candidate:
            cell.haveMarkup(fillNum)
                ? cell.removeMarkup(fillNum)
                : cell.addMarkup(fillNum);
        }
      }
      updateSudokuState(currentState, sudoku);
    }
  }

  void updateSudokuState(
    SudokuScreenStateSudoku currentState,
    Puzzle sudoku, {
    bool solved = false,
  }) {
    state = currentState.copyWith(sudoku: sudoku, solved: solved);
    notifyListeners();
  }
}
