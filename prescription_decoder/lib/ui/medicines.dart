import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prescription_decoder/ui/home.dart';


class Medicines extends StatefulWidget {
  const Medicines({Key? key}) : super(key: key);

  @override
  _MedicinesState createState() => _MedicinesState();
}

class _MedicinesState extends State<Medicines> {

  bool _isAscending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Ongoing Medications"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Home()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Medicines').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // Extract data from snapshot
            List<Map<String, dynamic>> records = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

            // Generate table rows
            List<TableRow> rows = [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[300]), // Optional: Adding a background color to the title row
                children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isAscending = !_isAscending; // Toggle sorting order
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              'Use',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              for (var record in records)
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(record['Name']),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(record['Use']),
                      ),
                    ),
                  ],
                ),
            ];

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(1), // Adjust the width as needed
                  1: FlexColumnWidth(1), // Adjust the width as needed
                },
                border: TableBorder.all(),
                children: rows,
              ),
            );


          },
        ),
      ),
    );
  }
}
