import 'package:sudoku_api/sudoku_api.dart';

extension CellUtils on Cell {
  int getIntValue() => getValue() ?? 0;

  bool hasValue() => getIntValue() > 0;

  bool haveMarkup(int num) => getMarkup()?.contains(num) ?? false;
}