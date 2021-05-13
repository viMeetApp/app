import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:signup_app/repositories/group_repository.dart';
import 'package:signup_app/common.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final GroupRepository _groupRepository = GroupRepository();

  Future<String> _uploadFileFromString(
      {required Uint8List data, required String firebasePath}) async {
    try {
      final ref = _firebaseStorage.ref(firebasePath);
      await ref.putData(data);

      final String dowloadUrl = await ref.getDownloadURL();
      return dowloadUrl;
    } catch (err) {
      viLog(err, "Error uploading File to firestore");
      return Future.error(ViImageUploadException());
    }
  }

  Future<void> uploadGroupPicture(
      {required Uint8List data, required Group group}) async {
    try {
      // upload file
      final String downloadUrl = await _uploadFileFromString(
          data: data, firebasePath: "group/pictures/${group.id}");

      // After upload also update value in group
      await _groupRepository.updateGroupFieldsViaMap(
          groupId: group.id, fieldsToBeUpdated: {'picture': downloadUrl});
    } catch (err) {
      viLog(err, "Error uploading Group Picture");
      return Future.error(ViImageUploadException());
    }
  }
}
