import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AboutWidget extends StatelessWidget {
  String legalFileName;

  AboutWidget({required this.legalFileName});

  Future<String> getData() async {
    try {
      return await rootBundle
          .loadString('assets/legal/' + legalFileName + '.md');
    } on FlutterError catch (_) {
      return "ERROR: Seite kann nicht geladen werden";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return new Markdown(
            data: snapshot.data ?? "",
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
          );
        });
  }
}
