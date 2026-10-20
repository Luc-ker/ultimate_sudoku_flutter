import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:ultimate_sudoku_flutter/ui/viewmodel/sudoku_screen_state.dart';
import 'package:ultimate_sudoku_flutter/ui/viewmodel/sudoku_screen_viewmodel.dart';

class SudokuScreen extends StatelessWidget {
  final SudokuScreenViewModel viewModel = SudokuScreenViewModel();
  final String title;

  SudokuScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SudokuScreenViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(child: SudokuScreenContent()),
      ),
    );
  }
}

class SudokuScreenContent extends StatefulWidget {
  const SudokuScreenContent({super.key});

  @override
  State<SudokuScreenContent> createState() => _SudokuScreenContentState();
}

class _SudokuScreenContentState extends State<SudokuScreenContent> {
  @override
  void initState() {
    super.initState();
    context.read<SudokuScreenViewModel>().generatePuzzle();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SudokuScreenViewModel>(
      builder: (BuildContext context, SudokuScreenViewModel vm, Widget? child) {
        return switch (vm.state) {
          SudokuScreenStateLoading() => CircularProgressIndicator(),
          SudokuScreenStatePuzzle(:final sudoku) => _DataState(sudoku: sudoku),
          SudokuScreenStateError(:final message) => _ErrorState(
            errorMessage: message,
          ),
        };
      },
    );
  }
}

class _DataState extends StatelessWidget {
  final Puzzle sudoku;

  const _DataState({required this.sudoku});

  @override
  Widget build(BuildContext context) {
    final matrix = sudoku.board()?.matrix();
    if (matrix != null) {
      return Column(
        children: List.generate(matrix.length, (int i) {
          return Row(
            children: List.generate(matrix.elementAt(i).length, (int j) {
              return Expanded(
                child: Text(
                  matrix.elementAt(i).elementAt(j).getValue().toString(),
                  textAlign: TextAlign.center,
                ),
              );
            }),
          );
        }),
      );
    } else {
      return Text(sudoku.toString());
    }
  }
}

class _ErrorState extends StatelessWidget {
  final String errorMessage;

  const _ErrorState({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorMessage));
  }
}
