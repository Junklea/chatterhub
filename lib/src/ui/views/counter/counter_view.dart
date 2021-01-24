import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'counter_viewmodel.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CounterViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(model.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: model.updateCounter,
        ),
      ),
      viewModelBuilder: () => CounterViewModel(),
    );
  }
}
