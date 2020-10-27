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
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
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
                  padding: const EdgeInsets.all(AppThemeData.varPaddingEdges),
                  child: Presets.getSignUpCard(
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 10,
                      children: [
                        Text(
                          "GruppenName",
                          style: AppThemeData.textHeading2,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                            "Ex sint rerum sed consequatur qui ut qui. Eius velit sunt aspernatur reprehenderit dolores. Eligendi eos exercitationem nobis a natus magni ab."),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RaisedButton(
                              onPressed: () => {},
                              child: Text("beitreten"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
