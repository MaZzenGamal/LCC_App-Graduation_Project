import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ValueNotifier<int>? _counter;

  @override
  void initState() {
    _counter = ValueNotifier<int>(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: _counter!,
          builder: (context, value, child) => Text(
            'You had tapped $value.',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _counter!.value++,
      ),
    );
  }

  @override
  void dispose() {
    _counter!.dispose();
    super.dispose();
  }
}
