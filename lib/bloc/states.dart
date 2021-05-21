import 'package:sudoku/models/map.dart';

abstract class SudokuState {
  final SudokuMap map;

  const SudokuState(this.map);
}

class GamingState extends SudokuState {
  const GamingState(SudokuMap map) : super(map);
}

class GamingSelectedState extends SudokuState {
  final int x;
  final int y;

  const GamingSelectedState(SudokuMap map, this.x, this.y) : super(map);
}

class InitState extends GamingState {
  InitState() : super(SudokuMap.init());
}

class GameOverState extends SudokuState {
  const GameOverState(SudokuMap map) : super(map);
}
