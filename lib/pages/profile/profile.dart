import "package:flutter/material.dart";
import "package:niku/niku.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Neko Desuyo"),
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
