import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sudoku_api/sudoku_api.dart';

part 'sudoku_screen_state.freezed.dart';

@freezed
sealed class SudokuScreenState with _$SudokuScreenState {
  const factory SudokuScreenState.loading(Puzzle sudoku) =
      SudokuScreenStateLoading;

  const factory SudokuScreenState.sudoku(
    Puzzle sudoku,
    int fillNumber,
    bool solved,
  ) = SudokuScreenStateSudoku;

  const factory SudokuScreenState.error(String message) =
      SudokuScreenStateError;
}
