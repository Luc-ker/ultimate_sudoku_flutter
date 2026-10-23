import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sudoku_api/sudoku_api.dart';

import '../../../models/fill_mode.dart';

part 'sudoku_screen_state.freezed.dart';

@freezed
sealed class SudokuScreenState with _$SudokuScreenState {
  const factory SudokuScreenState.loading({required Puzzle sudoku}) =
      SudokuScreenStateLoading;

  const factory SudokuScreenState.sudoku({
    required Puzzle sudoku,
    @Default(0) int selectedNumber,
    @Default(false) bool solved,
    @Default(FillMode.normal) FillMode fillMode,
  }) = SudokuScreenStateSudoku;

  const factory SudokuScreenState.error({required String message}) =
      SudokuScreenStateError;
}
