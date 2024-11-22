import 'package:flutter_pampotek/domain/entities/obat_entitiy.dart';
import 'package:flutter_pampotek/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pampotek/ui/providers/obat_provider.dart';
import 'package:provider/provider.dart';

class EditObatScreen extends StatefulWidget {
  const EditObatScreen({super.key});

  @override
  State<EditObatScreen> createState() => _EditObatScreenState();
}

class _EditObatScreenState extends State<EditObatScreen> {
  final TextEditingController namaObatController = TextEditingController();
  final TextEditingController deskripsiObatController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();

  void toHomeScreen() {
    Navigator.pop(context);
  }

  void handleSubmit() async {
    String namaObat = namaObatController.text;
    String deskripsiObat = deskripsiObatController.text;
    int jumlahObat = int.tryParse(jumlahController.text.trim()) ?? 0;

    await Provider.of<ObatProvider>(context, listen: false).addObat(ObatEntitiy(
        id: "",
        namaObat: namaObat,
        deskripsiObat: deskripsiObat,
        jumlahObat: jumlahObat));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final obat = ModalRoute.of(context)?.settings.arguments as ObatEntitiy;

    namaObatController.text = obat.namaObat;
    deskripsiObatController.text = obat.deskripsiObat;
    jumlahController.text = obat.jumlahObat.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit obat"),
        leading:
            IconButton(onPressed: toHomeScreen, icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        decoration: BoxDecoration(color: MaterialTheme.lightScheme().surface),
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: [
            MyTextForm(hint: "Nama Obat", controller: namaObatController),
            MyTextForm(hint: "Deskripsi", controller: deskripsiObatController),
            MyTextForm(hint: "Jumlah", controller: jumlahController),
            Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyCancelButton(text: "Batal", onPressed: toHomeScreen),
                MyButton(text: "Simpan", onPressed: handleSubmit)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyTextForm extends StatelessWidget {
  const MyTextForm({super.key, required this.hint, required this.controller});

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType = TextInputType.text;

    if (hint == "Jumlah") {
      keyboardType = TextInputType.number;
    } else {
      keyboardType = TextInputType.text;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        style: TextStyle(color: MaterialTheme.lightScheme().onSurfaceVariant),
        decoration: InputDecoration(
          labelText: hint,
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: MaterialTheme.lightScheme().onSurfaceVariant)),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.text, required this.onPressed});

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: MaterialTheme.lightScheme().primaryContainer,
          textStyle:
              TextStyle(color: MaterialTheme.lightScheme().onPrimaryContainer),
          minimumSize: const Size(130, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class MyCancelButton extends StatelessWidget {
  const MyCancelButton(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: MaterialTheme.lightScheme().errorContainer,
          textStyle:
              TextStyle(color: MaterialTheme.lightScheme().onErrorContainer),
          minimumSize: const Size(130, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
