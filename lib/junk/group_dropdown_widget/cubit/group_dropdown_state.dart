part of 'group_dropdown_cubit.dart';
//!Vermutlich gar nicht notwendig ich lasse jetzt aber mal da

class GroupDropdownState {
  final bool scrollable;
  Stream<List<Group>> groupStream;

  GroupDropdownState({@required this.scrollable, @required this.groupStream});

  factory GroupDropdownState.initial()=>GroupDropdownState(groupStream: Stream.empty(), scrollable: false);

  GroupDropdownState copyWith({  
    Stream<List<Group>> groupStream,
    bool scrollable
  }){
    
    return GroupDropdownState(groupStream: groupStream??this.groupStream, scrollable: scrollable??this.scrollable);
  }
}

