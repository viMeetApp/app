import 'package:flutter/material.dart';

class ViDropdownItem<T> {
  T value;
  String name;
  ViDropdownItem(this.value, this.name);
}

class ViDropdownButton<T> extends StatefulWidget {
  final List<ViDropdownItem<T>> elements;
  final String? hint;
  final Function? onChanged;

  ViDropdownButton({required this.elements, this.hint, this.onChanged});

  @override
  _ViDropdownButtonState createState() => _ViDropdownButtonState<T>();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ViDropdownButtonState<T> extends State<ViDropdownButton> {
  T? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: dropdownValue,
        isExpanded: true,
        hint: this.widget.hint != null ? Text(this.widget.hint!) : null,
        isDense: true,
        //value: "One",
        //icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        onChanged: (T? newValue) {
          setState(() {
            dropdownValue = newValue;
            if (widget.onChanged != null) widget.onChanged!(newValue);
          });
        },
        items: widget.elements.map<DropdownMenuItem<T>>((item) {
          return DropdownMenuItem(
            value: item.value,
            child: Text(item.name),
          );
        }).toList(),
      ),
    );
  }
}
