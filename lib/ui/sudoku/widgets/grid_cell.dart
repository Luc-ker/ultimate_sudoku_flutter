import 'package:material_ui/material_ui.dart';
import 'package:sudoku_api/sudoku_api.dart';

import '../../../models/fill_mode.dart';

class GridCell extends StatefulWidget {
  final Cell cell;
  final int cellIndex;
  final int fillNumber;
  final FillMode fillMode;
  final Function(int) onTap;

  const GridCell({
    super.key,
    required this.cell,
    required this.cellIndex,
    required this.fillNumber,
    required this.fillMode,
    required this.onTap,
  });

  @override
  State<GridCell> createState() => GridCellState();
}

class GridCellState extends State<GridCell> {
  List<int> notes = List.empty(growable: true);

  void onNoteInput(int fillNumber) {
    notes.contains(fillNumber)
        ? notes.remove(fillNumber)
        : notes.add(fillNumber);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localCell = widget.cell;
    final number = localCell.getValue();

    return Material(
      color: (number == widget.fillNumber && number != 0)
          ? Colors.grey.shade500
          : (localCell.prefill() ?? false)
          ? Colors.grey.shade300
          : Colors.transparent,
      child: InkWell(
        splashColor: Colors.indigo,
        hoverColor: Colors.indigoAccent,
        focusColor: Colors.indigoAccent,
        onTap: () => (widget.fillMode == FillMode.normal)
            ? widget.onTap(widget.cellIndex)
            : onNoteInput(widget.fillNumber),
        child: number != 0
            ? Center(
                child: Text(number.toString(), textAlign: TextAlign.center),
              )
            : SizedBox.expand(child: NoteCell(notes: notes)),
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
