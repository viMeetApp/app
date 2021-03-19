import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Class to manage the state of a ViBit Widget.
/// This can be extended to include all neccessary data regarding a widget
class ViState extends State<ViBit> {
  Function _onBuild;
  Function _onRefresh;

  /// associate the function to build child widgets to the state.
  /// This method should not be called directly!
  @nonVirtual
  set onBuild(Function onBd) {
    if (_onBuild != null) {
      throw Exception("onBuild can not be set multiple times");
    }
    _onBuild = onBd;
  }

  /// associate the function to build child widgets to the state.
  /// This method should not be called directly!
  @nonVirtual
  set onRefresh(Function onRf) {
    if (_onRefresh != null) {
      throw Exception("onRefresh can not be set multiple times. " +
          "Make sure you don't have a ViBitDynamic widget within a " +
          "onRefresh function of the same state");
    }
    _onRefresh = onRf;
  }

  /// get the refresh function
  @nonVirtual
  Function get onRefresh {
    return _onRefresh;
  }

  /// This method can be called to rebuild the widget after a change in
  /// the state. It prompts the 'onBuild' function from the related ViBit
  /// to be called
  @nonVirtual
  void refresh() {
    if (_onBuild != null) {
      if (_onRefresh != null) {
        onRefresh();
      } else {
        print("Warning: No ViBitDynamic widget was found in the scope");
      }
    } else {
      setState(() {});
    }
  }

  /// This function builds the actual widget.
  /// It should therefore not be interacted with directly
  @nonVirtual
  @override
  Widget build(BuildContext context) {
    return _onBuild != null
        ? _onBuild(context, this)
        : _onRefresh != null
            ? _onRefresh(context, this)
            : Text("ViBit: no child defined");
  }
}

/// This widget can be used together with a ViBit Widget to only rebuild certain
/// parts of a Widget on state changes
class ViBitDynamic<T extends ViState> extends StatefulWidget {
  final ViState state;
  final Function(BuildContext) onRefresh;
  final Function(BuildContext, T) onRefreshWithState;
  ViBitDynamic({@required this.state, this.onRefresh, this.onRefreshWithState});

  @override
  _ViBitDynamicState createState() => _ViBitDynamicState(this);
}

class _ViBitDynamicState extends State<ViBitDynamic> {
  _ViBitDynamicState(ViBitDynamic wgt) {
    print("set function");
    wgt.state.onRefresh = () {
      setState(() {});
    };
  }
  @override
  Widget build(BuildContext context) {
    return (widget.onRefreshWithState != null)
        ? widget.onRefreshWithState(context, widget.state)
        : widget.onRefresh(context);
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
  ViBit(
      {@required this.state,
      Function(BuildContext, T) onBuild,
      Function(BuildContext, T) onRefresh}) {
    state.onBuild = onBuild;
    state.onRefresh = onRefresh;
  }

  /// This method sets the connects the state with the widget.
  /// It should therefore not be overriden or called directly
  @nonVirtual
  @override
  ViState createState() => state;
}
