// import 'dart:convert';
// import 'dart:html';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class BluetoothSpeakerControlScreen extends StatefulWidget {
  const BluetoothSpeakerControlScreen({super.key});

  @override
  _BluetoothSpeakerControlScreenState createState() =>
      _BluetoothSpeakerControlScreenState();
}

class _BluetoothSpeakerControlScreenState
    extends State<BluetoothSpeakerControlScreen> {
  final database = FirebaseDatabase.instance.ref();
  bool isPlaying = false;
  double volumeLevel = 10;

  void togglePlayback() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying == true) {
        Uri url = Uri.parse(
            "https://speakeriot-64ab4-default-rtdb.asia-southeast1.firebasedatabase.app/datahttp.json");
        http.post(url,
            body: json.encode(
              {"play": 1},
            ));
        database.child('Data').child('play').set(1);
      }
      if (isPlaying == false) {
        Uri url = Uri.parse(
            "https://speakeriot-64ab4-default-rtdb.asia-southeast1.firebasedatabase.app/datahttp.json");
        http.post(url,
            body: json.encode(
              {"pause": 1},
            ));
        database.child('Data').child('pause').set(1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataControlRef = database.child('Data');
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 64, 52, 1),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Speaker Controller',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                color: Colors.blueGrey[900],
                child: const Center(
                  child: Text(
                    'MUSIC PLAYER ',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Volume',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Slider(
                            value: volumeLevel,
                            min: 0,
                            max: 30,
                            divisions: 30,
                            thumbColor: Colors.white,
                            activeColor: Colors.white,
                            inactiveColor: Colors.black,
                            onChanged: (newValue) {
                              setState(() {
                                dataControlRef
                                    .child('volume')
                                    .set(newValue.round());
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Shuffle logic
                              Uri url = Uri.parse(
                                  "https://speakeriot-64ab4-default-rtdb.asia-southeast1.firebasedatabase.app/datahttp.json");
                              http.post(url,
                                  body: json.encode(
                                    {"shuffle": 1},
                                  ));
                              dataControlRef.child('shuffle').set(1);
                            },
                            child: const Icon(
                              Icons.shuffle,
                              size: 34.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Previous Song logic
                    Uri url = Uri.parse(
                        "https://speakeriot-64ab4-default-rtdb.asia-southeast1.firebasedatabase.app/datahttp.json");
                    http.post(url,
                        body: json.encode(
                          {"previous": 1},
                        ));
                    dataControlRef.child('previous').set(1);
                  },
                  child: const Icon(
                    Icons.skip_previous,
                    size: 36.0,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: togglePlayback,
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 36.0,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Next Song logic
                    Uri url = Uri.parse(
                        "https://speakeriot-64ab4-default-rtdb.asia-southeast1.firebasedatabase.app/datahttp.json");
                    http.post(url,
                        body: json.encode(
                          {"next": 1},
                        ));
                    dataControlRef.child('next').set(1);
                  },
                  child: const Icon(
                    Icons.skip_next,
                    size: 36.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
