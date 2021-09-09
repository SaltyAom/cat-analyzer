import 'package:cat/models/cat.dart';
import 'package:cat/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:get/get.dart';
import 'package:cat/pages/analyzer/state.dart';

import 'package:niku/niku.dart';

import 'package:hive/hive.dart';

class PreviewPage extends HookWidget {
  const PreviewPage({Key? key}) : super(key: key);

  @override
  build(context) {
    final state = Get.find<AnalyzerPageState>();
    final isCat = state.confidence.value > 0.6;
    final catType = isCat ? state.catType.value : "Not cat";

    final nameController = useTextEditingController();
    final typeController = useTextEditingController(text: catType);
    final ageController = useTextEditingController();
    final owned = useState(false);

    final formKey = GlobalKey<FormState>();

    final handleSubmit = () async {
      if (!formKey.currentState!.validate()) return;

      final box = await Hive.openBox<CatModel>('cat');

      box.put(
        nameController.value.text,
        CatModel(
          name: nameController.value.text,
          type: typeController.value.text,
          age: int.tryParse(ageController.value.text) ?? 0,
          owned: owned.value,
          cover: state.image.value,
        ),
      );

      state.catType.value = '';
      Get.offAll(() => HomePage());
    };

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: NikuColumn([
              NikuColumn([
                Obx(
                  () => Image.memory(
                    state.image.value,
                  ).niku()
                    ..rounded(8)
                    ..shadows([
                      BoxShadow(
                        offset: Offset(0, 8),
                        color: Colors.black.withOpacity(.125),
                        blurRadius: 24,
                      ),
                    ])
                    ..maxWidth(560)
                    ..mt(16)
                    ..mb(36),
                ),
                useMemoized(
                  () => NikuTextField("Name")
                    ..controller(nameController)
                    ..fontSize(18)
                    ..b(InputBorder.none)
                    ..validator((value) {
                      if (value == null || value.isEmpty)
                        return "Cat need a name";
                    }),
                  [nameController],
                ),
                useMemoized(
                  () => NikuTextField("Breed")
                    ..controller(typeController)
                    ..fontSize(18)
                    ..initial(catType)
                    ..b(InputBorder.none),
                  [catType, typeController],
                ),
                NikuRow([
                  useMemoized(
                    () => NikuTextField("Age")
                        .controller(ageController)
                        .phoneKeyboard()
                        .fontSize(18)
                        .b(InputBorder.none)
                        .niku()
                          ..flex(1),
                    [ageController],
                  ),
                  CheckboxListTile(
                    title: const Text("Owned"),
                    value: owned.value,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      owned.value = value!;
                    },
                  ).niku()
                    ..flex(2),
                ]),
                NikuButton.elevated(
                  NikuRow([
                    NikuText("Save cat")
                      ..fontSize(21)
                      ..w500(),
                    Icon(Icons.add) //
                        .niku()
                        .ml(8),
                  ])
                    ..justifyCenter(),
                ) //
                    .onPressed(handleSubmit)
                    .py(16)
                    .shadow(Colors.transparent)
                    .niku()
                      ..fullWidth()
                      ..mt(28),
              ])
                ..mb(24),
            ]) //
                .justifyCenter()
                .itemsCenter()
                .niku()
                  ..fullWidth()
                  ..px(36),
          ),
        ),
      ),
    );
  }
}
