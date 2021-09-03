import 'package:flutter/material.dart';

import 'package:niku/niku.dart';

class CatPage extends StatefulWidget {
  CatPage({Key? key}) : super(key: key);

  @override
  _CatPageState createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
      ]),
      body: NikuColumn([
        Image.network(
                "https://www.rd.com/wp-content/uploads/2019/11/cat-10-e1573844975155-scaled.jpg",
                fit: BoxFit.cover)
            .niku()
              ..aspectRatio(1 / 1),
        NikuText("Godzilla").fontSize(30).w600().niku()
          ..pt(30)
          ..pb(4),
        NikuText("Happy tofu eating cat").fontSize(18),
        NikuColumn([
          NikuText("Gender: Witchcoric & Demgirl").fontSize(18),
          NikuText("Pronoun: Xe/Xir").fontSize(18),
          NikuText("Vaccination Record").fontSize(18),
        ]).itemsStart().niku()
          ..p(24).fullWidth()
      ]),
    );
  }
}
