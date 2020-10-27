import 'package:flutter/material.dart';
import 'package:signup_app/postList/view/post_list_view.dart';
import 'package:signup_app/util/presets.dart';

class GroupPage extends StatelessWidget {
  @override
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => GroupPage());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppThemeData.colorControls),
        backgroundColor: Colors.transparent,
        title: Text(
          "TODO: GruppenName",
          style: TextStyle(color: AppThemeData.colorControls),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: AppThemeData.colorControls,
              ),
              onPressed: null)
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: CircleAvatar(
                backgroundColor: AppThemeData.colorPlaceholder,
                backgroundImage:
                    AssetImage("assets/img/logo_light_text_trans.png"),
                maxRadius: 50,
                minRadius: 50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              color: AppThemeData.colorCard,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                      "Ex sint rerum sed consequatur qui ut qui. Eius velit sunt aspernatur reprehenderit dolores. Eligendi eos exercitationem nobis a natus magni ab.")
                ],
              ),
            ),
          ),
          Expanded(
            child: PostListView(),
          ),
        ]),
      ),
    );
  }
}
