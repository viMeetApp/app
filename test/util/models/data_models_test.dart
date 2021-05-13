import 'package:flutter_test/flutter_test.dart';
import 'package:signup_app/util/models/data_models.dart';

void main() {
  test("'empty' constructors", () {
    expect(DatabaseDocument.empty(), isA<DatabaseDocument>(),
        reason: "DatabaseDocument");
    expect(UserGeneratedDocument.empty(), isA<UserGeneratedDocument>(),
        reason: "UserGeneratedDocument");
    expect(UserReference.empty(), isA<UserReference>(),
        reason: "UserReference");
    expect(GroupUserReference.empty(), isA<GroupUserReference>(),
        reason: "GroupUserReference");
    expect(GroupReference.empty(), isA<GroupReference>(),
        reason: "GroupReference");
    expect(Post.empty(), isA<Post>(), reason: "Post");
    expect(Event.empty(), isA<Event>(), reason: "Event");
    expect(Buddy.empty(), isA<Buddy>(), reason: "Buddy");
    expect(Message.empty(), isA<Message>(), reason: "Message");
    expect(Group.empty(), isA<Group>(), reason: "Group");
    expect(Report.empty(), isA<Report>(), reason: "Report");
    expect(BugReport.empty(), isA<BugReport>(), reason: "BugReport");
  });
}
