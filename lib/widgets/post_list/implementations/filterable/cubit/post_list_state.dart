part of 'post_list_cubit.dart';

class PostListState extends PostListStateInterface {
  final List<String> searchTags;
  PostListState(
      {required Stream<List<Post>> postStream, this.searchTags = const []})
      : super(postStream: postStream);

  //Das wäre die Stelle um die letze Konfiguration zu laden
  factory PostListState.initial() {
    return PostListState(postStream: Stream.empty(), searchTags: []);
  }

  PostListState copyWith({Stream<List<Post>>? stream, List<String>? tags}) {
    return PostListState(
        postStream: stream ?? this.postStream,
        searchTags: tags ?? this.searchTags);
  }
}
