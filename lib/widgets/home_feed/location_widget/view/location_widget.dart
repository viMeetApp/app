import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/presets.dart';
import 'package:signup_app/widgets/home_feed/location_widget/cubit/location_widget_cubit.dart';
import 'package:signup_app/widgets/home_feed/location_widget/cubit/location_widget_state.dart';
import 'package:signup_app/widgets/home_feed/location_widget/view/location_dialog_widget.dart';

class LocationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationWidgetCubit>(
        create: (_) => LocationWidgetCubit(currentPlace: null),
        child: BlocBuilder<LocationWidgetCubit, LocationWidgetState>(
            builder: (context, state) {
          return FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on),
                Flexible(
                  child: Text(
                    state.currentPlace?.name ?? "Unbekannt",
                    style: AppThemeData.textHeading2(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext c) => LocationDialog(
                  state: state,
                  cubit: BlocProvider.of<LocationWidgetCubit>(context),
                ),
              );
              //BlocProvider.of<HomePageCubit>(context)
              //    .openGroups(context);
            },
          );
        }));
  }
}
