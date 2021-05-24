import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/widgets/shared/network_images/avatar/generic_network_avatar.dart';
import 'package:signup_app/widgets/shared/network_images/update_image/generic/cubit/update_image_cubit.dart';

typedef dynamic OnTapFunction(BuildContext context);

class GenericUpdateImage extends StatelessWidget {
  final UpdateImageCubit updateImageCubit;
  final double radius;
  final String? imageUrl;
  final OnTapFunction onTap;

  GenericUpdateImage(
      {double? radius,
      this.imageUrl,
      required this.onTap,
      required this.updateImageCubit})
      : this.radius = radius ?? 50;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateImageCubit, UpdateImageState>(
      bloc: updateImageCubit,
      builder: (BuildContext context, UpdateImageState state) {
        return GestureDetector(
          onTap: () {
            if (state.isUpdating == false) {
              onTap(context);
            } else {
              Tools.showSnackbar(context, "Bitte letztes update abwarten");
            }
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              GenericNetworkAvatar(
                placeHolderPath: "assets/img/app_icon.png",
                radius: radius,
                imageUrl: imageUrl,
              ),
              Positioned(
                left: 1.5 * radius,
                top: 0.08 * radius,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                      color: AppThemeData.colorPrimaryLight,
                      shape: BoxShape.circle),
                  child: state.isUpdating
                      ? CircularProgressIndicator(
                          //color: Colors.black,
                          )
                      : Icon(
                          Icons.edit,
                        ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
