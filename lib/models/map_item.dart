class SudokuMapItem extends Object {
  int? value;
  final bool locked;

  SudokuMapItem([this.value, this.locked = false]);

  @override
  bool operator ==(Object other) => other is SudokuMapItem && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
