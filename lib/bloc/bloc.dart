import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/bloc/events.dart';
import 'package:sudoku/bloc/states.dart';
import 'package:sudoku/models/map.dart';

class SudokuBloc extends Bloc<SudokuEvent, SudokuState> {
  SudokuMap _map = SudokuMap.init();
  int? x;
  int? y;

  SudokuBloc() : super(InitState());

  @override
  Stream<SudokuState> mapEventToState(SudokuEvent event) async* {
    if (event is SelectItemEvent) {
      x = event.x;
      y = event.y;
      yield GamingSelectedState(_map, x!, y!);
    } else if (event is SetValueEvent) {
      _map.setValue(x!, y!, event.value);
      yield GameOverState(_map);
      if (_map.isFilled()) {
        yield GameOverState(_map);
      } else {
        yield GamingSelectedState(_map, x!, y!);
      }
    } else if (event is ClearValueEvent) {
      _map.clearValue(x!, y!);
      yield GamingSelectedState(_map, x!, y!);
    } else if (event is RestartGameEvent) {
      _map = SudokuMap.init();
      yield InitState();
    }
  }
}
