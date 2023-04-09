import 'package:flutter/material.dart';
import 'package:tugas4_tpm/halaman_detail.dart';
import 'package:tugas4_tpm/halaman_utama.dart';
import 'package:tugas4_tpm/login_page.dart';
import 'bantuan_situs_rekomendasi.dart';
import 'data_hotel.dart';

class SitusRekomendasi extends StatefulWidget {
  const SitusRekomendasi({Key? key}) : super(key: key);

  @override
  State<SitusRekomendasi> createState() => _SitusRekomendasiState();
}

class _SitusRekomendasiState extends State<SitusRekomendasi> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Rekomendasi Hotel"),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BantuanSitusRekomendasi()));
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
              showDialog(context: context, builder: (context) => alert);
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HalamanUtama()));
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
        body: ListView.builder(
          itemBuilder: (context, index) {
            final DataHotel hotel = hotelList[index];
            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HalamanDetail(hotelIndex: index)),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.network(
                        hotel.imageUrl[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotel.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.star,
                                    size: 20, color: Colors.yellow),
                                Text(hotel.stars.toString()),
                                SizedBox(width: 10),
                                Text("|"),
                                SizedBox(width: 10),
                                Text("${hotel.roomPrice.toString()} / malam"),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              hotel.location,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: hotelList.length,
        ),
      ),
    );
  }
}