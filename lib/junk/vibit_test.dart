import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/vibit/vibit.dart';

class TestState extends ViState {
  int value = 1;

  void onClick() {
    value++;
    refresh();
  }
}

class ViBitTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(10),
      child: ViBit<TestState>(
        state: TestState(),
        onBuild: (context, state) {
          return FlatButton(
            //child: Text("Button"),
            child: Text(state.value.toString()),
            onPressed: state.onClick,
          );
        },
      ),
    );
  }
}
