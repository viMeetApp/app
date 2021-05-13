import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:signup_app/common.dart';

class GenericNetworkAvatar extends StatelessWidget {
  final String? imageUrl;
  final String placeHolderPath;
  final double radius;

  GenericNetworkAvatar(
      {this.imageUrl, double? radius, required this.placeHolderPath})
      : this.radius = radius ?? 30;
  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CircleAvatar(
          radius: radius,
          backgroundColor: AppThemeData.colorPlaceholder,
          backgroundImage: CachedNetworkImageProvider(imageUrl!));
    } else {
      return CircleAvatar(
        backgroundColor: AppThemeData.colorPlaceholder,
        backgroundImage: AssetImage(placeHolderPath),
        radius: radius,
      );
    }
  }
}
