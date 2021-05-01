import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/tools/tools.dart';
import 'package:signup_app/util/widgets/network_buttons/cubit/network_button_cubit.dart';

class ViNetworkIconButton extends StatelessWidget {
  ViNetworkIconButton(
      {required Future<void> Function() onPressed,
      required Icon icon,
      EdgeInsetsGeometry? padding,
      bool showError = false,
      bool showSuccess = false})
      : _onPressed = onPressed,
        _icon = icon,
        _showError = showError,
        _showSuccess = showSuccess,
        _padding = padding;
  final Future Function() _onPressed;
  final EdgeInsetsGeometry? _padding;
  final bool _showError;
  final bool _showSuccess;
  final Icon _icon;

  final NetworkButtonCubit _networkButtonCubit = NetworkButtonCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkButtonCubit, bool>(
        bloc: _networkButtonCubit,
        builder: (context, isUpdating) {
          return isUpdating
              ? Container(
                  padding: _padding ?? const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : IconButton(
                  icon: _icon,
                  padding: _padding ?? const EdgeInsets.all(8.0),
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
                        _networkButtonCubit.isLoading();
                      },
                    );
                  },
                );
        });
  }
}
