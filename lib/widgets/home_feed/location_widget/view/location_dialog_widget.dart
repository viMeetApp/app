import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/services/geo_service.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/home_feed/location_widget/cubit/location_widget_vibit.dart';

class LocationDialog extends StatefulWidget {
  LocationWidgetState state;

  LocationDialog({required this.state});

  @override
  _LocationDialogState createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  TextEditingController searchController = TextEditingController();
  _LocationDialogState() {
    //searchController.text = widget.state.currentPlace?.name ?? "";
  }

  void autofillCurrentPlace() async {
    String name = (await GeoService.getCurrentPlace()).name ?? "";
    searchController.text = name;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<PostalPlace> filteredPlaces = widget.state.places!
        .where((element) =>
            element.name!
                .toLowerCase()
                .startsWith(searchController.text.toLowerCase()) ||
            element.plz!
                .toLowerCase()
                .startsWith(searchController.text.toLowerCase()))
        .toList();

    return Container(
      //backgroundColor: Colors.transparent,
      margin: MediaQuery.of(context).viewInsets,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(AppThemeData.varPaddingCard * 3),
          constraints: BoxConstraints(maxHeight: 400, maxWidth: 300),
          child: Card(
            color: AppThemeData.colorBase,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                TextField(
                  autocorrect: false,
                  enableSuggestions: false,
                  style: TextStyle(
                      fontSize: 18,
                      color: AppThemeData.colorTextRegular,
                      fontWeight: FontWeight.bold),
                  controller: searchController,
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
                      onPressed: () {
                        autofillCurrentPlace();
                      },
                    ),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    child: widget.state.places == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: filteredPlaces.length,
                            itemBuilder: (BuildContext context, int index) {
                              print("updating..");
                              return Container(
                                //height: 50,
                                //color: Colors.amber[colorCodes[index]],
                                child: ListTile(
                                  title: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        filteredPlaces[index].plz! + "    ",
                                        style: TextStyle(
                                            color: AppThemeData
                                                .colorTextRegularLight),
                                      ),
                                      Expanded(
                                        child: Text(
                                          filteredPlaces[index].name!,
                                          //overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    widget.state
                                        .setCurrentPlace(filteredPlaces[index]);
                                  },
                                ),
                              );
                            }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
