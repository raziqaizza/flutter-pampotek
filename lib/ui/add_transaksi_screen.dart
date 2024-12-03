import 'package:flutter_pampotek/domain/entities/obat_entity.dart';
import 'package:flutter_pampotek/domain/entities/transaksi_entity.dart';
import 'package:flutter_pampotek/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pampotek/ui/providers/obat_provider.dart';
import 'package:flutter_pampotek/ui/providers/transaksi_provider.dart';
import 'package:provider/provider.dart';

class AddTransaksiScreen extends StatefulWidget {
  const AddTransaksiScreen({super.key});

  @override
  State<AddTransaksiScreen> createState() => _AddTransaksiScreenState();
}

List<String> list = <String>[];
late List<ObatEntity> obats;
int selectedStock = 0;

class _AddTransaksiScreenState extends State<AddTransaksiScreen> {
  final TextEditingController jumlahController = TextEditingController();
  String selectedNamaObat = '';
  String selectedSelectedObatIndex = "-1";

  void toHomeScreen() {
    Navigator.pop(context);
  }

  void handleSubmit() async {
    print("add transaksi");

    int jumlahObat = int.tryParse(jumlahController.text.trim()) ?? 0;

    ObatEntity selectedObat =
        obats[int.tryParse(selectedSelectedObatIndex) ?? 0];

    await Provider.of<TransaksiProvider>(context, listen: false).addTransaksi(
      TransaksiEntity(
        id: "",
        namaObat: selectedObat.namaObat,
        jumlahObat: jumlahObat,
        hargaObat: selectedObat.hargaObat * jumlahObat,
        tanggal: DateTime.now(),
      ),
    );

    print(selectedObat.id);

    await Provider.of<ObatProvider>(context, listen: false).editObat(
      ObatEntity(
          id: selectedObat.id,
          namaObat: selectedObat.namaObat,
          deskripsiObat: selectedObat.deskripsiObat,
          jumlahObat: selectedObat.jumlahObat - jumlahObat,
          hargaObat: selectedObat.hargaObat),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    obats = ModalRoute.of(context)?.settings.arguments as List<ObatEntity>;
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
        child: SafeArea(
          child: Column(
            children: [
              DropDownButton(
                onValueChanged: (value) {
                  setState(() {
                    selectedSelectedObatIndex = list.indexOf(value).toString();
                    selectedNamaObat =
                        value; // Menyimpan nama obat yang dipilih
                  });
                },
              ),
              MyTextForm(hint: "Jumlah", controller: jumlahController),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyCancelButton(text: "Batal", onPressed: toHomeScreen),
                  MyButton(
                    text: "Simpan",
                    onPressed: handleSubmit,
                    jumlahController: jumlahController,
                    selectedStock: selectedStock,
                  ),
                ],
              )
            ],
          ),
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

class MyButton extends StatefulWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.jumlahController,
    required this.selectedStock,
  });

  final String text;
  final Function()? onPressed;
  final TextEditingController jumlahController;
  final int selectedStock;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    widget.jumlahController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    int jumlahObat = int.tryParse(widget.jumlahController.text.trim()) ?? 0;
    setState(() {
      isEnabled = jumlahObat > 0 && jumlahObat <= widget.selectedStock;
    });
  }

  @override
  void dispose() {
    widget.jumlahController.removeListener(_updateButtonState);
    selectedStock = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled
          ? widget.onPressed
          : null, // Tombol disabled jika isEnabled false
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled
            ? MaterialTheme.lightScheme().primaryContainer
            : MaterialTheme.lightScheme().onSurfaceVariant.withOpacity(0.5),
        textStyle: TextStyle(
          color: isEnabled
              ? MaterialTheme.lightScheme().onPrimaryContainer
              : MaterialTheme.lightScheme().onSurface.withOpacity(0.5),
        ),
        minimumSize: const Size(130, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        widget.text,
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
  const DropDownButton({super.key, required this.onValueChanged});

  final ValueChanged<String> onValueChanged;

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Stok: $selectedStock",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        DropdownMenu<String>(
          width: 300,
          hintText: "Pilih obat",
          onSelected: (String? value) {
            setState(() {
              dropdownValue = value!;
              selectedStock =
                  obats.firstWhere((obat) => obat.namaObat == value).jumlahObat;
            });
            widget.onValueChanged(dropdownValue);
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
