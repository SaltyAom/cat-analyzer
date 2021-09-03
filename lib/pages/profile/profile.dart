import "package:flutter/material.dart";
import "package:niku/niku.dart";

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: NikuRow([
            NikuButton(
              Icon(
                Icons.chevron_left,
                size: 36,
              ),
            ).p(0).m(0).niku()
              ..bg(Colors.red),
            Text("Neko Desuyo")
          ]).itemsCenter(),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
        body: NikuColumn([NikuText("hello")]));
  }
}
