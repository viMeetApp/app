import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'group_seetings_state.dart';

class GroupSeetingsCubit extends Cubit<GroupSeetingsState> {
  GroupSeetingsCubit() : super(GroupSeetingsInitial());
}
