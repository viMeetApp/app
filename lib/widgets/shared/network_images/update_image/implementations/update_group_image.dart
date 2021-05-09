import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signup_app/services/storage_service.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/tools/tools.dart';
import 'package:signup_app/widgets/shared/network_images/update_image/generic_update_image.dart';

class UpdateGroupImage extends StatelessWidget {
  final Group group;
  final double? radius;

  final picker = ImagePicker();
  final StorageService _storageService = StorageService();

  UpdateGroupImage({required this.group, this.radius});

  Future _getImageFromCamera(BuildContext context) async {
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      _uploadImage(context: context, pickedImage: pickedImage);
    }
    Navigator.of(context).pop();
  }

  Future _getImageFromGallery(BuildContext context) async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    Future<void>? _onFinishFuture;
    if (pickedImage != null) {
      _onFinishFuture =
          _uploadImage(context: context, pickedImage: pickedImage);
    }
    Navigator.of(context).pop(_onFinishFuture);
  }

  Future<void> _uploadImage(
      {required BuildContext context, required PickedFile pickedImage}) async {
    final byteStream = await pickedImage.readAsBytes();
    Tools.showSnackbar(context,
        "Bild wird hochgeladen, bis die Änderungen in Kraft tretetn kann es einen Moment dauern");
    return _storageService.uploadGroupPicture(data: byteStream, group: group);
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
                  _getImageFromGallery(context);
                },
                child: Text("Aus Galerie"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _getImageFromCamera(context);
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GenericUpdateImage(
      imageUrl: group.picture,
      radius: radius,
      onTap: (context) {
        final result = showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return bottomSheet(context);
          },
        );
        return result;
      },
    );
  }
}
