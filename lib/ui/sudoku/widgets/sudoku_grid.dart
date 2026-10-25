import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:sudoku_api/sudoku_api.dart';

import '../../../models/fill_mode.dart';
import 'grid_cell.dart';

class SudokuGrid extends StatelessWidget {
  final List<List<Cell>> matrix;
  final int fillNumber;
  final FillMode fillMode;
  final Function(int) onTap;

  const SudokuGrid({
    super.key,
    required this.matrix,
    required this.fillNumber,
    required this.fillMode,
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
          return Container(
            foregroundDecoration: _getBorder(
              row,
              column,
              sqrt(matrix.length).toInt(),
            ),
            child: GridCell(
              cell: matrix.elementAt(row).elementAt(column),
              cellIndex: index,
              fillNumber: fillNumber,
              fillMode: fillMode,
              onTap: onTap,
            ),
          );
        },
      ),
    );
  }
}
