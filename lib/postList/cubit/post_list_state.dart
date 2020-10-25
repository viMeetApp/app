part of 'post_list_cubit.dart';


class PostListState {
  Stream<List<Post>> postStream;
  List<String> searchTags = [];
  PostListState({this.postStream, this.searchTags});

  //Das wäre die Stelle um die letze Konfiguration zu laden
  factory PostListState.initial() {
    return PostListState(postStream: Stream.empty(), searchTags: []);
  }

  PostListState copyWith({  
    Stream<List<Post>> stream,
    List<String> tags
  }){
    print("Copy");
    return PostListState(postStream: stream??this.postStream, searchTags: tags??this.searchTags);
  }
}
