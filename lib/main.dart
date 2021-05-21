import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/bloc/bloc.dart';
import 'package:sudoku/bloc/events.dart';
import 'package:sudoku/bloc/states.dart';
import 'package:sudoku/models/map_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SudokuBloc>(
        lazy: false,
        create: (_) => SudokuBloc(),
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: SudokuPage()));
  }
}

class SudokuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<SudokuBloc, SudokuState>(
            listener: (context, state) {
              if (state is GameOverState) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(title: Text('You won!'), actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              BlocProvider.of<SudokuBloc>(context).add(RestartGameEvent());
                            },
                            child: Text('Restart'))
                      ]);
                    });
              }
            },
            child: Column(children: [
              Table(
                  border: TableBorder.all(),
                  children: List<TableRow>.generate(9, (i) {
                    return TableRow(
                        children: List<SudokuTableItem>.generate(9, (j) {
                      return SudokuTableItem(j, i);
                    }));
                  })),
              const Buttons(),
              const ClearButton()
            ])));
  }
}

class SudokuTableItem extends StatelessWidget {
  final int x;
  final int y;

  const SudokuTableItem(this.x, this.y);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SudokuBloc, SudokuState>(builder: (context, state) {
      final SudokuMapItem item = state.map.numbers[y][x];
      Color? color;
      if (state is GamingSelectedState) {
        if (state.x == x && state.y == y) {
          color = Colors.grey[500];
        }
      }
      return SizedBox.fromSize(
          size: Size.square(MediaQuery.of(context).size.width / 9),
          child: Material(
              color: color,
              child: InkResponse(
                  onTap: item.locked
                      ? null
                      : () {
                          BlocProvider.of<SudokuBloc>(context).add(SelectItemEvent(x, y));
                        },
                  child: Center(child: Text(item.value?.toString() ?? '')))));
    });
  }
}

class Buttons extends StatelessWidget {
  const Buttons();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SudokuBloc, SudokuState>(builder: (context, state) {
      if (state is GamingSelectedState) {
        return Table(
            children: List<TableRow>.generate(3, (i) {
          return TableRow(
              children: List<ElevatedButton>.generate(3, (j) {
            final int number = i * 3 + j + 1;
            final bool available = state.map.isAvailable(state.x, state.y, number);
            print('$number: $available');
            return ElevatedButton(
                onPressed: available
                    ? () {
                        BlocProvider.of<SudokuBloc>(context).add(SetValueEvent(number));
                      }
                    : null,
                child: Text('$number'));
          }));
        }));
      }

      return const SizedBox();
    });
  }
}

class ClearButton extends StatelessWidget {
  const ClearButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SudokuBloc, SudokuState>(builder: (context, state) {
      if (state is GamingSelectedState) {
        return FloatingActionButton(
            onPressed: () {
              BlocProvider.of<SudokuBloc>(context).add(ClearValueEvent());
            },
            child: Icon(Icons.clear));
      }

      return const SizedBox();
    });
  }
}
