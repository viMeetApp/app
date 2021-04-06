import 'package:flutter/material.dart';

class ViDropdownButton extends StatefulWidget {
  List? elements;
  String? hint;
  Function? onChanged;

  ViDropdownButton({this.elements, this.hint, this.onChanged});

  @override
  _ViDropdownButtonState createState() => _ViDropdownButtonState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ViDropdownButtonState extends State<ViDropdownButton> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: dropdownValue,
        isExpanded: true,
        hint: Text("Typ des Problems"),
        isDense: true,
        //value: "One",
        //icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue;
            widget.onChanged!(newValue);
          });
        },
        items: widget.elements!.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
