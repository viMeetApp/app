import 'package:flutter/material.dart';
import 'package:signup_app/util/presets.dart';

class ViSelectableChip extends StatefulWidget {
  Widget label = Text("viChip");
  String value;
  Function onChanged;
  bool isActive;

  ViSelectableChip(
      {this.label, this.value, this.isActive = false, this.onChanged});

  @override
  _ViSelectableChipState createState() => _ViSelectableChipState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ViSelectableChipState extends State<ViSelectableChip> {
  _ViSelectableChipState() {
    //isActive = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          padding: const EdgeInsets.only(right: 10),
          child: widget.isActive
              ? Chip(
                  label: widget.label,
                  backgroundColor: AppThemeData.swatchPrimary[100],
                  elevation: 2,
                )
              : Chip(
                  label: widget.label,
                  backgroundColor: AppThemeData.colorCard,
                )),
      onTap: () => {
        setState(() {
          widget.isActive = !widget.isActive;
          if (widget.onChanged != null) {
            widget.onChanged(widget.isActive);
          }
        })
      },
    );
  }
}
