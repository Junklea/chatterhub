import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'demo_viewmodel.dart';

class DemoView extends StatelessWidget {
  const DemoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DemoViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text("lol"),
        ),
      ),
      viewModelBuilder: () => DemoViewModel(),
    );
  }
}
