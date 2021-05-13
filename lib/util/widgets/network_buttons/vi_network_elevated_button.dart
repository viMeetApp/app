import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:signup_app/util/tools/tools.dart';
import 'package:signup_app/util/widgets/network_buttons/cubit/network_button_cubit.dart';

class ViNetworkElevatedButton extends StatelessWidget {
  ViNetworkElevatedButton(
      {required this.onPressed,
      required this.child,
      this.showError = false,
      this.showSuccess = false});
  final Future Function() onPressed;
  final bool showError;
  final bool showSuccess;
  final Widget child;

  final NetworkButtonCubit _networkButtonCubit = NetworkButtonCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkButtonCubit, bool>(
      bloc: _networkButtonCubit,
      builder: (context, isUpdating) {
        return isUpdating
            ? Container(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : ElevatedButton(
                child: child,
                onPressed: () {
                  _networkButtonCubit.isLoading();
                  onPressed().then(
                    (value) {
                      if (showSuccess) {
                        Tools.showSnackbar(context, 'Success');
                      }
                    },
                  ).catchError(
                    (_) {
                      if (showError) Tools.showSnackbar(context, 'Error');
                    },
                  ).whenComplete(
                    () {
                      _networkButtonCubit.isNotLoading();
                    },
                  );
                },
              );
      },
    );
  }
}
