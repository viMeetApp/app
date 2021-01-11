import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/util/presets.dart';

const DEMO_RESULTS = <String>[
  "12345   Neustadt",
  "54321   Altstadt",
  "12121   Weststadt-Nord",
  "34343   Süddorf",
  "12321   Ostenhausen",
  "54345   Obenstadt",
  "98765   Untenburg"
];

class LocationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        heightFactor: 0.6,
        child: Card(
          color: AppThemeData.colorBase,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          margin: EdgeInsets.all(AppThemeData.varPaddingCard * 3),
          child: Column(
            children: [
              TextField(
                autocorrect: false,
                enableSuggestions: false,
                style: TextStyle(
                    fontSize: 18,
                    color: AppThemeData.colorTextInverted,
                    fontWeight: FontWeight.bold),
                //controller: _nameController,
                decoration: Presets.getTextFieldDecorationHintStyle(
                  hintText: "Ortsname oder PLZ",
                  fillColor: AppThemeData.colorCard,
                  hintStyle: TextStyle(fontWeight: FontWeight.normal),
                  prefixIcon: IconButton(
                    padding: EdgeInsets.only(left: 9),
                    icon: Icon(
                      Icons.location_on,
                      color: AppThemeData.colorPrimary,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: ListView.builder(
                      itemCount: DEMO_RESULTS.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          //color: Colors.amber[colorCodes[index]],
                          child: ListTile(
                            title: Text(DEMO_RESULTS[index]),
                            onTap: () => {},
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
