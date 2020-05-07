library flutter_counter;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(CounterWidget());

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Counter>( // <=== PROVIDER
      create: (context) => Counter(),
      child: MaterialApp(
        title: 'Counter App - Compact',
        home: Scaffold(
          appBar: AppBar(
            title: Text("Page Title"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<Counter>( // <=== DEPENDENT
                  builder: (context, counter, child) => Text(
                    '${counter.count}',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
                Builder(builder: (context) { // <=== DEPENDENT
                  final counter = Provider.of<Counter>(context, listen: false);
                  return RaisedButton(
                    onPressed: () => counter.increment(),
                    child: Text("Increment"),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Counter with ChangeNotifier {
  int count = 0;

  void increment() {
    ++count;
    notifyListeners();
  }
}