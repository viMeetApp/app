import 'package:flutter/material.dart';
import 'package:signup_app/util/presets/presets.dart';
import 'package:signup_app/util/tools/tools.dart';
import 'package:signup_app/widgets/shared/network_images/avatar/generic_network_avatar.dart';

typedef Future<void> onTapFunction(BuildContext context);

class GenericUpdateImage extends StatefulWidget {
  final double radius;
  final String? imageUrl;
  final onTapFunction onTap;

  GenericUpdateImage({double? radius, this.imageUrl, required this.onTap})
      : this.radius = radius ?? 50;

  @override
  _GenericUpdateImageState createState() => _GenericUpdateImageState();
}

class _GenericUpdateImageState extends State<GenericUpdateImage> {
  bool isUpdating = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isUpdating == false) {
          setState(() {
            isUpdating = true;
          });
          widget.onTap(context).whenComplete(() => setState(() {
                isUpdating = false;
              }));
        } else {
          Tools.showSnackbar(context, "Bitte letztes update abwarten");
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GenericNetworkAvatar(
            placeHolderPath: "assets/img/app_icon.png",
            radius: widget.radius,
            imageUrl: widget.imageUrl,
          ),
          Positioned(
            left: 1.5 * widget.radius,
            top: 0.08 * widget.radius,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: new BoxDecoration(
                  color: AppThemeData.colorPrimaryLight,
                  shape: BoxShape.circle),
              child: isUpdating
                  ? CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.edit,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
