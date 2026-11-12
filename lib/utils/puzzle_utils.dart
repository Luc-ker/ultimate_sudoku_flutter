import 'package:sudoku_api/sudoku_api.dart';

extension PuzzleUtils on Puzzle {
  bool wasCellPrefilled(Position pos) =>
      board()?.cellAt(pos).prefill() ?? false;

  bool isBoardFullyFilled() {
    final matrix = board()?.matrix();
    return (matrix != null)
        ? !matrix.any((row) => row.any((cell) => cell.getValue() == 0))
        : false;
  }
}
