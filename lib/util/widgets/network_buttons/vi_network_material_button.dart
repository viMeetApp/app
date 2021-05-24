import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:signup_app/common.dart';
import 'package:signup_app/util/widgets/network_buttons/cubit/network_button_cubit.dart';

class ViNetworkMaterialButton extends StatelessWidget {
  ViNetworkMaterialButton(
      {required this.onPressed,
      required this.child,
      this.color,
      this.showSuccess = false,
      this.showError = false,
      this.textColor,
      this.disabledTextColor,
      this.disabledColor,
      this.focusColor,
      this.hoverColor,
      this.highlightColor,
      this.splashColor});
  final Future Function() onPressed;
  final Color? color;
  final bool showError;
  final bool showSuccess;
  final Widget child;

  final Color? textColor;
  final Color? disabledTextColor;
  final Color? disabledColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final Color? splashColor;

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
              : MaterialButton(
                  child: child,
                  color: color,
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
                  textColor: textColor,
                  disabledTextColor: disabledTextColor,
                  disabledColor: disabledTextColor,
                  focusColor: focusColor,
                  highlightColor: highlightColor,
                  splashColor: splashColor,
                );
        });
  }
}
