import 'package:material_ui/material_ui.dart';

class SudokuNumbers extends StatelessWidget {
  final int selectedNumber;
  final Function(int) onTap;

  const SudokuNumbers({
    super.key,
    required this.selectedNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        spacing: 2.0,
        children: List.generate(9, (int index) {
          return Expanded(
            child: Material(
              color: (index + 1 == selectedNumber)
                  ? Colors.grey.shade500
                  : Colors.grey.shade200,
              child: InkWell(
                splashColor: Colors.grey.shade700,
                onTap: () => onTap(index + 1),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text((index + 1).toString()),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
