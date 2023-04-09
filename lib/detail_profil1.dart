import 'package:flutter/material.dart';
import 'package:tugas4_tpm/halaman_utama.dart';
import 'login_page.dart';

class HalamanProfilIndrawani extends StatefulWidget {
  const HalamanProfilIndrawani({Key? key}) : super(key: key);

  @override
  State<HalamanProfilIndrawani> createState() => _HalamanProfilIndrawaniState();
}

class _HalamanProfilIndrawaniState extends State<HalamanProfilIndrawani> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details'),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage (
                    'images/iin.jpg'
                ),
                radius: 80,
              ),
              SizedBox(height: 16),
              Text(
                'INDRAWANI',
                style: TextStyle (
                    fontSize: 20, fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 8),
              Text(
                '123200018',
                style: TextStyle (
                    fontSize: 16
                ),
              ),
              SizedBox(height: 24),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('View Profile Details'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text('Nama'),
                      subtitle: Text('Indrawani'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.school),
                      title: Text('Kelas'),
                      subtitle: Text('Teknologi Dan Pemrograman Mobile IF-B'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text('Tempat, Tanggal Lahir'),
                      subtitle: Text('Bungkolo, 23 Desember 2001'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.lightbulb),
                      title: Text('Harapan / Cita-cita'),
                      subtitle: Text('Lulus cepat dengan gelar cumlaude kalau bisa, dapat kerja dengan gaji puluhan juta, dan membahagiakan orang tua, amin ya allah:)'),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}