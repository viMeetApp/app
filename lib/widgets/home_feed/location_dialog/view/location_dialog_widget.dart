import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/services/geo_service.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/home_feed/location_dialog/cubit/location_dialog_cubit.dart';
import 'package:signup_app/widgets/home_feed/location_dialog/cubit/location_dialog_state.dart';

class LocationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationDialogCubit>(
        create: (_) => LocationDialogCubit(currentPlace: null),
        child: BlocBuilder<LocationDialogCubit, LocationDialogState>(
            builder: (context, state) {
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
                        child: state.places == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: state.places.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    //height: 50,
                                    //color: Colors.amber[colorCodes[index]],
                                    child: ListTile(
                                      title: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.places[index].plz + "    ",
                                            style: TextStyle(
                                                color: AppThemeData
                                                    .colorTextRegularLight),
                                          ),
                                          Expanded(
                                            child: Text(
                                              state.places[index].name,
                                              //overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
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
        }));
  }
}
