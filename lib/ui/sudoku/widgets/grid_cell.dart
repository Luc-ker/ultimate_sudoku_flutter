import 'package:material_ui/material_ui.dart';
import 'package:sudoku_api/sudoku_api.dart';

class GridCell extends StatelessWidget {
  final Cell cell;
  final int cellIndex;
  final int fillNumber;
  final Function(int) onTap;

  const GridCell({
    super.key,
    required this.cell,
    required this.cellIndex,
    required this.fillNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final number = cell.getValue();

    return Material(
      color: (number == fillNumber && number != 0)
          ? Colors.grey.shade500
          : (cell.prefill() ?? false)
          ? Colors.grey.shade300
          : Colors.transparent,
      child: InkWell(
        splashColor: Colors.indigo,
        hoverColor: Colors.indigoAccent,
        focusColor: Colors.indigoAccent,
        onTap: () => onTap(cellIndex),
        child: number != 0
            ? Center(
                child: Text(number.toString(), textAlign: TextAlign.center),
              )
            : SizedBox.expand(
                child: NoteCell(notes: cell.getMarkup()?.toList() ?? <int>[]),
              ),
      ),
    );
  }
}

class NoteCell extends StatelessWidget {
  final List<int> notes;

  const NoteCell({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 9,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int idx) {
        return Center(
          child: Text(
            notes.contains(idx + 1) ? (idx + 1).toString() : '',
            style: const TextStyle(fontSize: 9),
          ),
        );
      },
    );
  }
}
