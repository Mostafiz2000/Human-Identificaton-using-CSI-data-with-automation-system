import 'package:flutter/material.dart';
import 'data.dart';

class detail extends StatefulWidget {
  const detail({super.key});

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(children: [
        SizedBox(
          height: 100,
        ),
        Container(
          width: 350,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Text(
            "Details of Signal",
            style: TextStyle(fontSize: 30.0, color: Colors.orange),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Text(
            "Human Movement Status: " + data[0]['status'],
            style: TextStyle(fontSize: 15.0, color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Text(
            "Max Amplitude: " + data[0]['maxAmplitude'],
            style: TextStyle(fontSize: 15.0, color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Text(
            "Min Amplitude: " + data[0]['minAmplitude'],
            style: TextStyle(fontSize: 15.0, color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Text(
            "Time: " + data[0]['time'],
            style: TextStyle(fontSize: 15.0, color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Text(
            "Environment: " + data[0]['envo'],
            style: TextStyle(fontSize: 15.0, color: Colors.grey),
          ),
        ),
      ]),
    );
  }
}
