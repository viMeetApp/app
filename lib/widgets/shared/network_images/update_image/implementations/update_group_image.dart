import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signup_app/services/storage_service.dart';
import 'package:signup_app/common.dart';
import 'package:signup_app/widgets/shared/network_images/update_image/generic/cubit/update_image_cubit.dart';
import 'package:signup_app/widgets/shared/network_images/update_image/generic/generic_update_image.dart';

class UpdateGroupImage extends StatelessWidget {
  final Group group;
  final double? radius;

  final picker = ImagePicker();
  final StorageService _storageService = StorageService();

  UpdateGroupImage({required this.group, this.radius});

  Future _getImageFromCamera(
      {required BuildContext context,
      required UpdateImageCubit updateImageCubit}) async {
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    if (pickedImage != null) {
      _uploadImage(
          context: context,
          pickedImage: pickedImage,
          updateImageCubit: updateImageCubit);
    }
    Navigator.of(context).pop();
  }

  Future _getImageFromGallery(
      {required BuildContext context,
      required UpdateImageCubit updateImageCubit}) async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _uploadImage(
              context: context,
              pickedImage: pickedImage,
              updateImageCubit: updateImageCubit)
          .onError((error, stackTrace) => Tools.showSnackbar(
              context, "Es gab ein Fehler beim Hochladen des Bildes"));
    }
    Navigator.of(context).pop();
  }

  Future<void> _uploadImage(
      {required BuildContext context,
      required PickedFile pickedImage,
      required UpdateImageCubit updateImageCubit}) async {
    Tools.showSnackbar(context,
        "Bild wird hochgeladen, bis die Änderungen in Kraft tretetn kann es einen Moment dauern");
    updateImageCubit.setIsUpdating(true);
    final byteStream = await pickedImage.readAsBytes();
    await _storageService.uploadGroupPicture(data: byteStream, group: group);
    updateImageCubit.setIsUpdating(false);
  }

  Widget bottomSheet(
      {required BuildContext context,
      required UpdateImageCubit updateImageCubit}) {
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
                  _getImageFromGallery(
                      context: context, updateImageCubit: updateImageCubit);
                },
                child: Text("Aus Galerie"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _getImageFromCamera(
                      context: context, updateImageCubit: updateImageCubit);
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
    final UpdateImageCubit _updateImageCubit = UpdateImageCubit();
    return GenericUpdateImage(
      updateImageCubit: _updateImageCubit,
      imageUrl: group.picture,
      radius: radius,
      onTap: (context) {
        final result = showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return bottomSheet(
                context: context, updateImageCubit: _updateImageCubit);
          },
        );
        return result;
      },
    );
  }
}
