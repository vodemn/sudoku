abstract class SudokuEvent {
  const SudokuEvent();
}

class RestartGameEvent extends SudokuEvent {
  const RestartGameEvent();
}

class SelectItemEvent extends SudokuEvent {
  final int x;
  final int y;

  const SelectItemEvent(this.x, this.y);
}

class SetValueEvent extends SudokuEvent {
  final int value;

  const SetValueEvent(this.value);
}

class ClearValueEvent extends SudokuEvent {
  const ClearValueEvent();
}
