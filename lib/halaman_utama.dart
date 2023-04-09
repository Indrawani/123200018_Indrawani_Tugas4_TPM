import 'package:flutter/material.dart';
import 'package:tugas4_tpm/bantuan_halaman_utama.dart';
import 'package:tugas4_tpm/daftar_anggota.dart';
import 'package:tugas4_tpm/login_page.dart';
import 'package:tugas4_tpm/situs_rekomendasi.dart';
import 'package:tugas4_tpm/stopwatch.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({Key? key}) : super(key: key);

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Menu Utama"),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: colorScheme.surface,
          selectedItemColor: Colors.blue,
          unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
          selectedLabelStyle: textTheme.caption,
          unselectedLabelStyle: textTheme.caption,
          onTap: (value) {
            if (value == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BantuanHalamanUtama()));
            } else if (value == 2) {
              AlertDialog alert = AlertDialog(
                title: Text("Logout"),
                content: Container(
                  child: Text("Apakah Anda Yakin Ingin Logout?"),
                ),
                actions: [
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                  TextButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
              showDialog(context: context, builder: (context) => alert);;
            }
            // Respond to item press.
            setState(() => _currentIndex = value);
          },
          items: [
            BottomNavigationBarItem(
              title: Text('Halaman Utama'),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text('Bantuan'),
              icon: Icon(Icons.help),
            ),
            BottomNavigationBarItem(
              title: Text('Logout'),
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/logo.png',
                    width: 180,
                    height: 180,
                  ),
                  Text(
                    'Selamat Datang di Aplikasi',
                    style: TextStyle(fontSize: 25),
                  ),
                  buttonDatarAnggota(context),
                  buttonStopwatch(context),
                  buttonSitusRekomendasi(context),
                ]),
          ),
        ]),
      ),
    );
  }
}

Widget buttonDatarAnggota(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(bottom: 20, left: 60, right: 60, top: 35),
    child: Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return DaftarAnggota();
              }));
        },
        child: const Text('Get Start Daftar Anggota'),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
        ),
      ),
    ),
  );
}

Widget buttonStopwatch(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(bottom: 20, left: 60, right: 60, top: 0),
    child: Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return const StopwatchPage();
              }));
        },
        child: const Text('Get Start Stopwatch'),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
        ),
      ),
    ),
  );
}

Widget buttonSitusRekomendasi(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(bottom: 0, left: 60, right: 60, top: 0),
    child: Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return  SitusRekomendasi();
              }));
        },
        child: const Text('Get Start Situs Rekomendasi'),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
        ),
      ),
    ),
  );
}