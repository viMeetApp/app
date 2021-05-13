import 'package:flutter/material.dart';
import 'package:signup_app/common.dart';

class ViSelectableChip extends StatefulWidget {
  final Widget label;
  final Function? onChanged;
  final bool isActive;

  ViSelectableChip(
      {this.label = const Text("viChip"),
      this.isActive = false,
      this.onChanged});

  @override
  _ViSelectableChipState createState() =>
      _ViSelectableChipState(isActive: isActive);
}

/// This is the private State class that goes with MyStatefulWidget.
class _ViSelectableChipState extends State<ViSelectableChip> {
  bool isActive;
  _ViSelectableChipState({required this.isActive});

  Widget getChip({Widget? child, required bool isActive}) {
    return Container(
      child: widget.label,
      padding: EdgeInsets.only(top: 7, bottom: 7, left: 9, right: 9),
      //margin: EdgeInsets.only(right: 10, bottom: 5, top: 5),
      decoration: BoxDecoration(
        border: Border.all(
            width: 3,
            color: isActive
                ? AppThemeData.colorPrimaryLighter
                : Colors.transparent),
        color: isActive ? AppThemeData.swatchPrimary[100] : Color(0xFFdedede),
        borderRadius: BorderRadius.circular(100),
      ), // .all(AppThemeData.varCardRadius)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: getChip(child: widget.label, isActive: widget.isActive),
      onTap: () => {
        setState(
          () {
            isActive = !isActive;
            if (widget.onChanged != null) {
              widget.onChanged!(isActive);
            }
          },
        )
      },
    );
  }
}
