import 'package:material_ui/material_ui.dart';

import '../../../models/fill_mode.dart';

class FillModeSwitcher extends StatelessWidget {
  final FillMode currentFillMode;
  final Function(FillMode) onTap;

  const FillModeSwitcher({
    super.key,
    required this.currentFillMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fillModes = FillMode.values;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        spacing: 2.0,
        children: List.generate(fillModes.length, (int index) {
          final thisFillMode = fillModes.elementAt(index);
          final isSelectedFillMode = currentFillMode == thisFillMode;
          return Container(
            color: isSelectedFillMode
                ? Colors.grey.shade500
                : Colors.grey.shade200,
            child: InkWell(
              onTap: () => onTap(thisFillMode),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(thisFillMode.toString()),
              ),
            ),
          );
        }),
      ),
    );
  }
}
