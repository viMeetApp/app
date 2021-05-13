import 'package:flutter/material.dart';
import 'package:signup_app/widgets/shared/network_images/avatar/generic_network_avatar.dart';

class NetworkAvatarGroup extends StatelessWidget {
  final String? imageUrl;
  final double? radius;

  NetworkAvatarGroup({this.imageUrl, this.radius});
  @override
  Widget build(BuildContext context) {
    return GenericNetworkAvatar(
        imageUrl: imageUrl,
        radius: radius,
        placeHolderPath: "assets/img/app_icon.png");
  }
}
