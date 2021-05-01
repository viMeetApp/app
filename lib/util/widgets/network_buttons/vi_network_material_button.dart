import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:signup_app/util/tools/tools.dart';
import 'package:signup_app/util/widgets/network_buttons/cubit/network_button_cubit.dart';

class ViNetworkMaterialButton extends StatelessWidget {
  ViNetworkMaterialButton(
      {required Future<void> Function() onPressed,
      required Widget child,
      EdgeInsetsGeometry? padding,
      Color? color,
      bool showError = false,
      bool showSuccess = false})
      : _onPressed = onPressed,
        _child = child,
        _showError = showError,
        _showSuccess = showSuccess,
        _color = color;
  final Future Function() _onPressed;
  final Color? _color;
  final bool _showError;
  final bool _showSuccess;
  final Widget _child;

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
                  child: _child,
                  color: _color,
                  onPressed: () {
                    _networkButtonCubit.isLoading();
                    _onPressed().then(
                      (value) {
                        if (_showSuccess) {
                          Tools.showSnackbar(context, 'Success');
                        }
                      },
                    ).catchError(
                      (_) {
                        if (_showError) Tools.showSnackbar(context, 'Error');
                      },
                    ).whenComplete(
                      () {
                        _networkButtonCubit.isNotLoading();
                      },
                    );
                  },
                );
        });
  }
}
