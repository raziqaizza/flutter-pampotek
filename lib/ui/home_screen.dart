import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pampotek/data/models/data_layer.dart';
import '../util.dart';
import '../theme.dart';
import 'package:flutter_pampotek/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);

    List<Obat> items = List<Obat>.generate(
      20,
      (i) => Obat(
          namaObat: "Panadol", deskripsiObat: "Deskripsi Obat", jumlahObat: 20),
    );

    return Container(
      color: MaterialTheme.lightScheme().surface,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              flexibleSpace: AppBarCard(username: "username"),
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 2, 12, 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyHeader(text: "Daftar Obat"),
                        MyButton(text: "Button", onPressed: () => {})
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 330,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ItemWidget(
                              namaObat: items[index].namaObat,
                              deskripsiObat: items[index].deskripsiObat,
                              jumlahObat: items[index].jumlahObat);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 2, 12, 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyHeader(text: "Transaksi"),
                        MyButton(text: "Button", onPressed: () => {})
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 330,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ItemWidget(
                              namaObat: items[index].namaObat,
                              deskripsiObat: items[index].deskripsiObat,
                              jumlahObat: items[index].jumlahObat);
                        },
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.namaObat,
    required this.deskripsiObat,
    required this.jumlahObat,
  });

  final String namaObat;
  final String deskripsiObat;
  final int jumlahObat;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MaterialTheme.lightScheme().surfaceContainer,
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12, 24, 12, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      namaObat,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      deskripsiObat,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                jumlahObat.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppBarCard extends StatelessWidget {
  const AppBarCard({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: MaterialTheme.lightScheme().surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SizedBox(
        height: 58,
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 12, 0, 12),
          child: Text(
            "Selamat datang, $username!",
            style: TextStyle(
                color: MaterialTheme.lightScheme().onTertiaryContainer),
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
          minimumSize: Size(120, 38),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class MyHeader extends StatelessWidget {
  const MyHeader({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
