import 'package:flutter/material.dart';
import 'package:flutter_pampotek/data/repositories/auth_repository_impl.dart';
import 'package:flutter_pampotek/di.dart';
import 'package:flutter_pampotek/domain/entities/obat_entity.dart';
import 'package:flutter_pampotek/ui/providers/obat_provider.dart';
import 'package:flutter_pampotek/ui/providers/transaksi_provider.dart';
import 'package:provider/provider.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final obatProvider = Provider.of<ObatProvider>(context, listen: false);
    final transaksiProvider =
        Provider.of<TransaksiProvider>(context, listen: false);

    obatProvider.fetchObat();
    transaksiProvider.fetchTransaksi();

    void toAddObatScreen() {
      Navigator.pushNamed(context, "/addObat");
    }

    void toEditObatScreen(ObatEntity obat) {
      Navigator.pushNamed(context, "/editObat", arguments: obat);
    }

    void toAddTransaksiScreen() {
      Navigator.pushNamed(context, "/addTransaksi");
    }

    return Container(
      color: MaterialTheme.lightScheme().surface,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: AppBarCard(),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyHeader(text: "Daftar Obat"),
                      MyButton(text: "Tambah", onPressed: toAddObatScreen)
                    ],
                  ),
                ),
                SizedBox(
                  height: 380,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    child: Consumer<ObatProvider>(
                      builder: (context, obatProvider, child) {
                        return ListView.builder(
                          itemCount: obatProvider.obats.length,
                          itemBuilder: (context, index) {
                            final obat = obatProvider.obats[index];
                            return ItemWidgetObat(
                              onTap: () => toEditObatScreen(obat),
                              id: obat.id,
                              namaObat: obat.namaObat,
                              hargaObat: "Rp. ${obat.hargaObat}",
                              deskripsiObat: obat.deskripsiObat,
                              jumlahObat: obat.jumlahObat,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyHeader(text: "Transaksi"),
                      MyTransaksiButton(
                        text: "Tambah",
                        onPressed: () => toAddTransaksiScreen(),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 380,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    child: Consumer<TransaksiProvider>(
                      builder: (context, transaksiProvider, child) {
                        return ListView.builder(
                          itemCount: transaksiProvider.transaksi.length,
                          itemBuilder: (context, index) {
                            final transaksi =
                                transaksiProvider.transaksi[index];
                            return ItemWidgetTransaksi(
                              id: transaksi.id,
                              namaObat: transaksi.namaObat,
                              hargaObat: "Rp. ${transaksi.hargaObat}",
                              jumlahObat: transaksi.jumlahObat,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemWidgetObat extends StatelessWidget {
  const ItemWidgetObat(
      {super.key,
      required this.id,
      required this.namaObat,
      required this.deskripsiObat,
      required this.jumlahObat,
      required this.hargaObat,
      this.onTap});

  final String id;
  final String namaObat;
  final String deskripsiObat;
  final int jumlahObat;
  final String hargaObat;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: MaterialTheme.lightScheme().surfaceContainer,
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        namaObat,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        hargaObat.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  jumlahObat.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await Provider.of<ObatProvider>(context, listen: false)
                      .deleteObat(id);
                },
                icon: Icon(
                  Icons.delete,
                  color: MaterialTheme.lightScheme().error,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemWidgetTransaksi extends StatelessWidget {
  const ItemWidgetTransaksi({
    super.key,
    required this.id,
    required this.namaObat,
    required this.jumlahObat,
    required this.hargaObat,
  });

  final String id;
  final String namaObat;
  final int jumlahObat;
  final String hargaObat;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: MaterialTheme.lightScheme().surfaceContainer,
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        namaObat,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        hargaObat.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  jumlahObat.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await Provider.of<TransaksiProvider>(context, listen: false)
                      .deleteTransaksi(id);
                },
                icon: Icon(
                  Icons.delete,
                  color: MaterialTheme.lightScheme().error,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarCard extends StatelessWidget {
  const AppBarCard({super.key});

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
          padding: const EdgeInsets.fromLTRB(12, 5, 5, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Selamat datang!",
                style: TextStyle(
                    color: MaterialTheme.lightScheme().onTertiaryContainer),
              ),
              IconButton(
                onPressed: () async {
                  await locator<AuthRepositoryImpl>().logoutUser();
                  Navigator.pushReplacementNamed(context, '/');
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.text, this.onPressed});

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
          minimumSize: const Size(120, 38),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            width: 8,
          ),
          const Icon(Icons.add)
        ],
      ),
    );
  }
}

class MyTransaksiButton extends StatelessWidget {
  const MyTransaksiButton({super.key, required this.text, this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: MaterialTheme.lightScheme().primaryContainer,
          textStyle:
              TextStyle(color: MaterialTheme.lightScheme().onPrimaryContainer),
          minimumSize: const Size(120, 38),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            width: 8,
          ),
          const Icon(Icons.add)
        ],
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
