import 'package:flutter/material.dart';
import 'bantuan_situs_rekomendasi.dart';
import 'data_hotel.dart';
import 'halaman_utama.dart';
import 'login_page.dart';

class MenuFavorite extends StatefulWidget {
  const MenuFavorite({Key? key}) : super(key: key);

  @override
  State<MenuFavorite> createState() => _MenuFavoriteState();
}

class _MenuFavoriteState extends State<MenuFavorite> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hotel Favorite"),
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
            List hotel = hotelList.where((element) => element.favorite == true).toList();
            DataHotel data = hotel[index];
            return Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.network(
                      data.imageUrl[0],
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
                            data.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.star,
                                  size: 20, color: Colors.yellow),
                              Text(data.stars.toString()),
                              SizedBox(width: 10),
                              Text("|"),
                              SizedBox(width: 10),
                              Text("${data.roomPrice.toString()} / malam"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            data.location,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: hotelList.where((element) => element.favorite == true).toList().length,
        ),
      ),
    );
  }
}
