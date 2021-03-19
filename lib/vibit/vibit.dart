import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Class to manage the state of a ViBit Widget.
/// This can be extended to include all neccessary data regarding a widget
class ViState extends State<ViBit> {
  Function _onBuild;

  /// associate the function to build child widgets to the state.
  /// This method should not be called directly!
  @nonVirtual
  set onBuild(Function onBuild) {
    _onBuild = onBuild;
  }

  /// This method can be called to rebuild the widget after a change in
  /// the state. It prompts the 'onBuild' function from the related ViBit
  /// to be called
  @nonVirtual
  void refresh() {
    setState(() {});
  }

  /// This function builds the actual widget.
  /// It should therefore not be interacted with directly
  @nonVirtual
  @override
  Widget build(BuildContext context) {
    return _onBuild != null
        ? _onBuild(context, this)
        : Text("ViBit: no child defined");
  }
}

/// This class is an extension of the StatefulWidget class.
/// It allows for easier seperation of logic and user interface by
/// keeping data state object indipendent from the Widget build cycle
class ViBit<T extends ViState> extends StatefulWidget {
  final ViState state;

  /// [state] holds all information the widget needs
  ///
  /// [onBuild] is the function that returns possible child widgets of this one.
  ViBit({@required this.state, Function(BuildContext, T) onBuild}) {
    state.onBuild = onBuild;
  }

  /// This method sets the connects the state with the widget.
  /// It should therefore not be overriden or called directly
  @nonVirtual
  @override
  ViState createState() => state;
}
