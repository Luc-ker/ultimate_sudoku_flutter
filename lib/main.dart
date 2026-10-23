import 'package:material_ui/material_ui.dart';
import 'package:ultimate_sudoku_flutter/ui/sudoku/sudoku_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SudokuScreen(title: 'Sudoku!'),
    );
  }
}
