import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/util/presets.dart';

class BugReportPage extends StatelessWidget {
  ///Set Group argument when post is Created out of Group
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => BugReportPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Problem melden"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          //runSpacing: 10,
          //spacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                "Diese Beschreibung wird an die Entwickler von viMeet übermittelt. Deine Beschreibung hilft uns sehr unsere App zu verbessern. Danke :)",
                style: TextStyle(fontSize: 15),
              ),
            ),
            TextField(
              decoration: Presets.getTextFieldDecorationHintStyle(
                  hintText: "Kurzbeschreibung"),
            ),
            Presets.simpleCard(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text("Typ des Problems"),
                  isDense: true,
                  //value: "One",
                  //icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (String newValue) {
                    /*setState(() {
          dropdownValue = newValue;
        });*/
                  },
                  items: <String>[
                    'Benutzeroberfläche',
                    'App Logik',
                    'fehlende Funktion',
                    'sonstige'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            TextField(
              minLines: 10,
              maxLines: 10,
              decoration: Presets.getTextFieldDecorationHintStyle(
                  hintText:
                      "Beschreibung des Problems\n- wann tritt er auf \n- was geschieht nach dem Fehler"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}
