import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/util/tools/tools.dart';
import 'package:signup_app/util/widgets/network_buttons/cubit/network_button_cubit.dart';

class ViNetworkIconButton extends StatelessWidget {
  ViNetworkIconButton(
      {required this.onPressed,
      this.showError = false,
      this.showSuccess = false,
      required this.icon});
  final Future Function() onPressed;
  final bool showError;
  final bool showSuccess;
  final Icon icon;

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
              : IconButton(
                  icon: icon,
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
                        _networkButtonCubit.isLoading();
                      },
                    );
                  },
                );
        });
  }
}
