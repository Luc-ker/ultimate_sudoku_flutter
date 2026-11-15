import 'dart:collection';

Map<String, dynamic> sudokuFromJson(Map<String, dynamic> json) {
  return {
    "board": _boardFromJson(json["board"]),
    "solved_board": _boardFromJson(json["solved_board"]),
    "options": json["options"],
    "time_elapsed_in_seconds": json["time_elapsed_in_seconds"],
  };
}

Map<String, dynamic> _boardFromJson(Map<String, dynamic> json) {
  final matrix = json["matrix"];
  if (matrix is List<dynamic> &&
      matrix.first is List<dynamic> &&
      matrix.first.first is Map<String, dynamic>) {
    return {
      "matrix": matrix
          .map(
            (row) => (row as List<dynamic>)
                .map((cell) => _cellFromJson(cell))
                .toList(),
          )
          .toList(),
    };
  }
  return {"matrix": []};
}

Map<String, dynamic> _cellFromJson(Map<String, dynamic> json) {
  return {
    "value": json["value"],
    "is_prefill": json["is_prefill"],
    "is_valid": json["is_valid"],
    "markup": HashSet<int>.from(json["markup"] as List<dynamic>),
    "is_pristine": json["is_pristine"],
    "position": json["position"],
  };
}

Map<String, dynamic> sudokuToJson(Map<String, dynamic> sudoku) {
  return {
    "board": _boardToJson(sudoku["board"]),
    "solved_board": _boardToJson(sudoku["solved_board"]),
    "options": sudoku["options"],
    "time_elapsed_in_seconds": sudoku["time_elapsed_in_seconds"],
  };
}

Map<String, dynamic> _boardToJson(Map<String, dynamic> board) {
  final matrix = board["matrix"];
  if (matrix is List<dynamic> &&
      matrix.first is List<dynamic> &&
      matrix.first.first is Map<String, dynamic>) {
    return {
      "matrix": matrix
          .map(
            (row) => (row as List<dynamic>)
                .map((cell) => _cellToJson(cell))
                .toList(),
          )
          .toList(),
    };
  }
  return {"matrix": []};
}

Map<String, dynamic> _cellToJson(Map<String, dynamic> cell) {
  return {
    "value": cell["value"],
    "is_prefill": cell["is_prefill"],
    "is_valid": cell["is_valid"],
    "markup": (cell["markup"] as HashSet<int>).toList(growable: false),
    "is_pristine": cell["is_pristine"],
    "position": cell["position"],
  };
}
