import 'package:flutter/cupertino.dart';
import 'package:signup_app/repositories/group_repository.dart';
import 'package:signup_app/services/authentication/authentication_service.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/vibit/vibit.dart';

enum Types { submitted, error, invalid, processing, active }

class GroupCreatorState extends ViState {
  AuthenticationService _authService;

  Exception? error;
  TextEditingController titleController = new TextEditingController();
  TextEditingController aboutController = new TextEditingController();

  GroupCreatorState({AuthenticationService? authenticationService})
      : _authService = authenticationService ?? AuthenticationService(),
        super(type: Types.active);

  void submit() async {
    try {
      FocusScope.of(context).unfocus();
      type = Types.processing;
      String title = titleController.value.text;
      String about = aboutController.value.text;
      if (title == "" || about == "") {
        type = Types.invalid;
        return;
      }

      final currentUserRef = _authService.getCurrentUserReference();
      Group newGroup = Group(
        name: title,
        about: about,
        isPrivate: false,
        //! this is not safe!
        members: [
          GroupUserReference(
              name: currentUserRef.name,
              id: currentUserRef.id,
              picture: currentUserRef.picture,
              isAdmin: true)
        ],
      );

      await GroupRepository().createGroup(newGroup);
      type = Types.submitted;
    } catch (e) {
      error = e as Exception;
      type = Types.error;
    }
  }
}
