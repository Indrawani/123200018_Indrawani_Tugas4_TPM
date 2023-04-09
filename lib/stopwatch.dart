import 'package:flutter/material.dart';
import 'package:tugas4_tpm/login_page.dart';
import 'dart:async';
import 'bantuan_halaman_stopwatch.dart';
import 'halaman_utama.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({Key? key}) : super(key: key);

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final _duration = const Duration(seconds: 1);
  var _stopwatch = Stopwatch();
  var _time = "00:00:00";
  var _history = <String>[];
  bool _isRunning = false;
  int _currentIndex = 0;

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  void _startTimer() {
    Timer(_duration, _keepRunning);
  }

  void _keepRunning() {
    if (_stopwatch.isRunning) {
      _startTimer();
    }
    setState(() {
      _time = _stopwatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
    });
    _stopwatch.start();
    _startTimer();
  }

  void _stopStopwatch() {
    setState(() {
      _isRunning = false;
    });
    _stopwatch.stop();
  }

  void _resetStopwatch() {
    setState(() {
      _isRunning = false;
      _time = "00:00:00";
      _history.clear();
    });
    _stopwatch.reset();
  }

  void _addHistory() {
    setState(() {
      _history.add(_time);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: new Text("Stopwatch"),
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
                MaterialPageRoute(builder: (context) => BantuanHalamanStopwatch()));
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Text(
              _time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 70,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: _isRunning ? null : _startStopwatch,
                ),
                FloatingActionButton(
                  child: Icon(Icons.stop),
                  onPressed: _isRunning ? _stopStopwatch : null,
                ),
                FloatingActionButton(
                  child: Icon(Icons.refresh),
                  onPressed: _resetStopwatch,
                ),
                FloatingActionButton(
                  child: Icon(Icons.history),
                  onPressed: _addHistory,
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}