import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:ultimate_sudoku_flutter/models/fill_mode.dart';
import 'package:ultimate_sudoku_flutter/ui/sudoku/viewmodel/sudoku_screen_state.dart';
import 'package:ultimate_sudoku_flutter/ui/sudoku/viewmodel/sudoku_screen_viewmodel.dart';
import 'package:ultimate_sudoku_flutter/ui/sudoku/widgets/fill_mode_switcher.dart';
import 'package:ultimate_sudoku_flutter/ui/sudoku/widgets/sudoku_grid.dart';
import 'package:ultimate_sudoku_flutter/ui/sudoku/widgets/sudoku_numbers.dart';

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
          SudokuScreenStateSudoku(
            :final sudoku,
            :final fillNumber,
            :final fillMode,
            :final solved,
          ) =>
            _DataState(
              sudoku: sudoku,
              fillNumber: fillNumber,
              fillMode: fillMode,
              solved: solved,
              onCellTap: vm.fillCell,
              onFillModeTap: vm.switchFillMode,
              selectFillNumberTap: vm.selectFillNumber,
            ),
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
  final int fillNumber;
  final FillMode fillMode;
  final bool solved;
  final Function(int) onCellTap;
  final Function(FillMode) onFillModeTap;
  final Function(int) selectFillNumberTap;

  const _DataState({
    required this.sudoku,
    required this.fillNumber,
    required this.fillMode,
    required this.solved,
    required this.onCellTap,
    required this.onFillModeTap,
    required this.selectFillNumberTap,
  });

  @override
  Widget build(BuildContext context) {
    final matrix = sudoku.board()?.matrix();
    if (matrix != null) {
      return CustomScrollView(
        slivers: [
          SudokuGrid(
            matrix: matrix,
            fillNumber: fillNumber,
            onTap: onCellTap,
          ),
          SliverList.list(
            children: [
              const SizedBox(height: 20),
              FillModeSwitcher(currentFillMode: fillMode, onTap: onFillModeTap),
              const SizedBox(height: 20),
            ],
          ),
          SudokuNumbers(
            numberCount: matrix.length,
            fillNumber: fillNumber,
            onTap: selectFillNumberTap,
          ),
          if (solved)
            const SliverToBoxAdapter(child: Text('You solved the Sudoku!')),
        ],
      );
    } else {
      return const Text('Sudoku grid couldn\'t be loaded :(');
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
