import 'package:sudoku/models/map_item.dart';

class SudokuMap {
  final List<List<SudokuMapItem>> numbers;

  const SudokuMap(this.numbers);

  factory SudokuMap.init() {
    final init = [
      [5, 3, 0, 0, 7, 0, 0, 0, 0],
      [6, 0, 0, 1, 9, 5, 0, 0, 0],
      [0, 9, 8, 0, 0, 0, 0, 6, 0],
      [8, 0, 0, 0, 6, 0, 0, 0, 3],
      [4, 0, 0, 8, 0, 3, 0, 0, 1],
      [7, 0, 0, 0, 2, 0, 0, 0, 6],
      [0, 6, 0, 0, 0, 0, 2, 8, 0],
      [0, 0, 0, 4, 1, 9, 0, 0, 5],
      [0, 0, 0, 0, 8, 0, 0, 7, 9]
    ];
    final List<List<SudokuMapItem>> result = [];
    for (int i = 0; i < 9; i++) {
      result.add([]);
      for (int j = 0; j < 9; j++) {
        if (init[i][j] != 0) {
          result[i].add(SudokuMapItem(init[i][j], true));
        } else {
          result[i].add(SudokuMapItem());
        }
      }
    }
    return SudokuMap(result);
  }

  List<SudokuMapItem> column(int x) {
    return List<SudokuMapItem>.generate(9, (index) {
      return numbers[index][x];
    });
  }

  List<SudokuMapItem> row(int y) {
    return numbers[y];
  }

  bool isAvailable(int x, int y, int value) {
    return !row(y).contains(SudokuMapItem(value)) && !column(x).contains(SudokuMapItem(value));
  }

  bool isFilled() {
    for (int i = 0; i < 9; i++) {
      if (row(i).contains(SudokuMapItem())) {
        return false;
      }
    }

    return true;
  }

  void setValue(int x, int y, int value) {
    numbers[y][x].value = value;
  }

  void clearValue(int x, int y) {
    numbers[y][x].value = null;
  }
}
