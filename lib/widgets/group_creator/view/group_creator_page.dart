import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:signup_app/util/presets.dart';

class GroupCreatorPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => GroupCreatorPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemeData.colorPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppThemeData.colorTextInverted),
        title: Text("neue Gruppe erstellen",
            style: AppThemeData.textHeading2(
                color: AppThemeData.colorTextInverted)),
        backgroundColor: AppThemeData.colorPrimary,
      ),
      body: Container(
        //padding: EdgeInsets.all(AppThemeData.varPaddingNormal * 2),
        child: Column(
          //direction: Axis.vertical,
          children: [
            Theme(
                data: ThemeData.dark(),
                child: Container(
                    padding: EdgeInsets.only(
                        left: AppThemeData.varPaddingNormal * 2,
                        right: AppThemeData.varPaddingNormal * 2,
                        bottom: AppThemeData.varPaddingNormal * 2),
                    child: TextField(
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      maxLength: 30,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          //labelText: 'Password',
                          hintText: "Name"),
                    ))),
            Expanded(
              child: Container(
                  decoration: new BoxDecoration(
                      color: AppThemeData.colorCard,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0),
                      )),
                  padding: EdgeInsets.all(AppThemeData.varPaddingNormal * 2),
                  child: ListView(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none, //OutlineInputBorder(),
                            labelText: "Beschreibung",
                            alignLabelWithHint: true),
                        maxLines: 4,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.check,
          color: AppThemeData.colorTextInverted,
        ),
        onPressed: () {},
      ),
    );
  }
}
