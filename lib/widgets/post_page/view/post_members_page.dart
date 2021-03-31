import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/util/models/data_models.dart';
import 'package:signup_app/util/tools/entwicklungs_tools.dart';

class PostMembersPage extends StatelessWidget {
  final Event event;
  PostMembersPage(this.event);

  static Route route({required Event event}) {
    return MaterialPageRoute<void>(builder: (_) {
      return (PostMembersPage(event));
    });
  }

  Widget getMemberTile(String user) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            user,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          )
        ],
        //children: [Text(user.name ?? "unbekannter Nutzer")],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teilnehmer"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            EntwicklungsTools.getTODOWidget(
                "komplette Nutzer laden.\nggf. Nutzernamen mit Post in Datenbank speichern"),
            for (String member in event.participants ?? [])
              getMemberTile(member)
          ],
        ),
      ),
    );
  }
}
