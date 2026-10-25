import 'package:material_ui/material_ui.dart';

class SudokuNumbers extends StatelessWidget {
  final int numberCount;
  final int fillNumber;
  final Function(int) onTap;

  const SudokuNumbers({
    super.key,
    required this.numberCount,
    required this.fillNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final totalItems = numberCount + 1;
    return SliverGrid.builder(
      itemCount: totalItems,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (totalItems / 2).round(),
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        final currNum = index + 1;
        return Material(
          color: (currNum == fillNumber)
              ? Colors.grey.shade500
              : Colors.grey.shade200,
          child: InkWell(
            splashColor: Colors.grey.shade700,
            onTap: () => onTap(currNum),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(currNum == 10 ? 'X' : (currNum).toString()),
              ),
            ),
          ),
        );
      },
    );
  }
}
