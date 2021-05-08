import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signup_app/util/presets/presets.dart';
import 'package:signup_app/widgets/shared/network_images/avatar/generic_network_avatar.dart';

class GenericUpdateImage extends StatelessWidget {
  final double radius;
  final String? imageUrl;

  final picker = ImagePicker();

  Future getImageFromCamera() async {
    await picker.getImage(source: ImageSource.camera);
  }

  Future getImageFromGallery() async {
    await picker.getImage(source: ImageSource.gallery);
  }

  Widget bottomSheet(context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Bild hochladen"),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                getImageFromGallery();
              },
              child: Text("Aus Galerie"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                getImageFromCamera();
              },
              child: Text("Kamera"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: Text("Aus Vorlagen wählen"),
            ),
          )
        ],
      ),
    ));
  }

  GenericUpdateImage({this.radius = 50, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Tap but it does not look that good");
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return bottomSheet(context);
            });
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
                  child: Icon(
                    Icons.edit,
                  )))
        ],
      ),
    );
  }
}
