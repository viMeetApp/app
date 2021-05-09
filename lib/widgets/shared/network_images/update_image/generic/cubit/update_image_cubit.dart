import 'package:bloc/bloc.dart';

part 'update_image_state.dart';

class UpdateImageCubit extends Cubit<UpdateImageState> {
  UpdateImageCubit() : super(UpdateImageState(isUpdating: false));

  void setIsUpdating(bool isUpdating) {
    emit(UpdateImageState(isUpdating: isUpdating));
  }
}
