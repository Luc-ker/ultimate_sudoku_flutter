import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:sudoku_api/sudoku_api.dart';

class SudokuGrid extends StatelessWidget {
  final List<List<Cell>> matrix;
  final int selectedNumber;
  final Function(int) onTap;

  const SudokuGrid({
    super.key,
    required this.matrix,
    required this.selectedNumber,
    required this.onTap,
  });

  double _getBorderWidth(int index, int modFactor, int res, int edge) {
    return (index % modFactor == res)
        ? (index == edge)
              ? 4
              : 2
        : 1;
  }

  BoxDecoration _getBorder(int row, int column, int modFactor) {
    return BoxDecoration(
      border: BoxBorder.fromSTEB(
        start: BorderSide(width: _getBorderWidth(column, modFactor, 0, 0)),
        top: BorderSide(width: _getBorderWidth(row, modFactor, 0, 0)),
        end: BorderSide(
          width: _getBorderWidth(column, modFactor, 2, matrix.length - 1),
        ),
        bottom: BorderSide(
          width: _getBorderWidth(row, modFactor, 2, matrix.length - 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      sliver: SliverGrid.builder(
        itemCount: matrix.length * matrix.first.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: matrix.length,
        ),
        itemBuilder: (BuildContext context, int index) {
          final row = (index / matrix.length).toInt();
          final column = index % matrix.length;
          final cell = matrix.elementAt(row).elementAt(column);
          final number = cell.getValue();
          return Container(
            foregroundDecoration: _getBorder(
              row,
              column,
              sqrt(matrix.length).toInt(),
            ),
            child: Material(
              color: (number == selectedNumber && number != 0)
                  ? Colors.grey.shade500
                  : (cell.prefill() ?? false)
                  ? Colors.grey.shade300
                  : Colors.transparent,
              child: InkWell(
                splashColor: Colors.indigo,
                hoverColor: Colors.indigoAccent,
                focusColor: Colors.indigoAccent,
                onTap: (cell.prefill() != true) ? () => onTap(index) : () {},
                child: Center(
                  child: Text(
                    number != 0 ? number.toString() : '',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
