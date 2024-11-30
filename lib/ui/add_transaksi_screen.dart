import 'package:flutter_pampotek/domain/entities/obat_entitiy.dart';
import 'package:flutter_pampotek/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pampotek/ui/providers/obat_provider.dart';
import 'package:provider/provider.dart';

class AddTransaksiScreen extends StatefulWidget {
  const AddTransaksiScreen({super.key});

  @override
  State<AddTransaksiScreen> createState() => _AddTransaksiScreenState();
}

List<String> list = <String>[];

class _AddTransaksiScreenState extends State<AddTransaksiScreen> {
  final TextEditingController jumlahController = TextEditingController();
  final String stok = "";

  void toHomeScreen() {
    Navigator.pop(context);
  }

  void handleSubmit() async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final obats =
        ModalRoute.of(context)?.settings.arguments as List<ObatEntitiy>;
    list = obats.map((value) => value.namaObat).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Transaksi"),
        leading: IconButton(
            onPressed: toHomeScreen, icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        decoration: BoxDecoration(color: MaterialTheme.lightScheme().surface),
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: [
            DropDownButton(
              obats: obats,
            ),
            MyTextForm(hint: "Jumlah", controller: jumlahController),
            const Spacer(flex: 1),
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
            borderSide:
                BorderSide(color: MaterialTheme.lightScheme().onSurfaceVariant),
          ),
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

class DropDownButton extends StatefulWidget {
  const DropDownButton({super.key, required this.obats});

  final List<ObatEntitiy> obats;

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  String dropdownValue = '';
  int currentStock = 0;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.obats.first.namaObat;
    currentStock = widget.obats.first.jumlahObat;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Stok: $currentStock",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        DropdownMenu<String>(
          width: double.infinity,
          initialSelection: list.first,
          onSelected: (String? value) {
            setState(() {
              dropdownValue = value!;
              currentStock = widget.obats
                  .firstWhere((obat) => obat.namaObat == value)
                  .jumlahObat;
            });
          },
          dropdownMenuEntries:
              list.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(
              value: value,
              label: value,
            );
          }).toList(),
        ),
      ],
    );
  }
}
