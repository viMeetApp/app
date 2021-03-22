import 'package:flutter/cupertino.dart';
import 'package:signup_app/vibit/vibit.dart';

enum Types { submitted, error, invalid, processing, active }

class GroupCreatorState extends ViState {
  Exception error;
  TextEditingController titleController = new TextEditingController();
  TextEditingController aboutController = new TextEditingController();

  GroupCreatorState() : super(type: Types.active);

  void submit() {
    try {
      type = Types.processing;
      String title = titleController.value.text;
      String about = aboutController.value.text;
      if (title == "" || about == "") {
        type = Types.invalid;
      }
      throw Exception("NO_BACKEND_IMPLEMENTED");
      //_setType(Types.submitted);
    } catch (e) {
      error = e;
      type = Types.error;
    }
  }
}
