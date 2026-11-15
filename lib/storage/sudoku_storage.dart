import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:ultimate_sudoku_flutter/storage/sudoku_serialization.dart';

class SudokuStorage {
  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/sudoku.json');
  }

  Future<Map<String, dynamic>> readSudoku() async {
    try {
      final file = await _localFile;
      final json = jsonDecode(await file.readAsString());

      return sudokuFromJson(json);
    } catch (_) {
      throw Exception("Something went wrong when trying to parse sudoku!");
    }
  }

  Future<File> writeSudoku(Map<String, dynamic> sudoku) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(sudokuToJson(sudoku)));
  }
}