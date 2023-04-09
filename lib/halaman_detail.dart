import 'package:flutter/material.dart';
import 'package:tugas4_tpm/halaman_utama.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data_hotel.dart';
import 'login_page.dart';

class HalamanDetail extends StatefulWidget {
  final int hotelIndex;

  const HalamanDetail({Key? key, required this.hotelIndex}) : super(key: key);

  @override
  State<HalamanDetail> createState() => _HalamanDetailState();
}

class _HalamanDetailState extends State<HalamanDetail> {
  int _currentIndex = 0;
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    final DataHotel detailHotel = hotelList[widget.hotelIndex];
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(detailHotel.name),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: IconButton(
                  icon: Icon(
                    toggle ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: toggleFavorite,
                ),
              ),
            ],
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
              }
              else {
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
                title: Text('Logout'),
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          body: ListView(children: [
            Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        //bisa di slide
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Image.network(detailHotel.imageUrl[index]),
                              );
                            },
                            pageSnapping: true,
                            itemCount: detailHotel.imageUrl.length,
                          ),
                        ),
                      ),
                      TextButton(
                        child: Text(detailHotel.name,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black)),
                        onPressed: () async {
                          _launchURL(detailHotel.websiteLink);
                        },
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0; i < int.parse(detailHotel.stars); i++)
                              const Icon(Icons.star, color: Colors.limeAccent),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 2),
                        child: Text(
                          'Location : ${detailHotel.location}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 2),
                        child: Text(
                          'Price : ${detailHotel.roomPrice}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: SizedBox(height: 400, child: _fasilitas()),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }

  Widget _fasilitas() {
    DataHotel detaiData = hotelList[widget.hotelIndex];
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(IconData(
                        int.parse(detaiData.iconFacility[index]),
                        fontFamily: 'MaterialIcons')),
                    title: Text(detaiData.facility[index]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: detaiData.facility.length,
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void toggleFavorite() {
    setState(() {
      if (toggle) {
        toggle = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Favorite dihapus'),backgroundColor: Colors.red),
        );
      } else {
        toggle = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Favorite ditambahkan'),backgroundColor: Colors.green),
        );
      }
    });
  }
}
