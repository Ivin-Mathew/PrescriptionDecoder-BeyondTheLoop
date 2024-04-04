import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  String? convertedText;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchDataFromFirestore();
  }

  Future<void> _fetchDataFromFirestore() async {
    try {
      // Fetch only one document from Firestore
      final snapshot = await FirebaseFirestore.instance.collection('Records').limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data() as Map<String, dynamic>;
        final imageUrl = data['Url'] as String;

        // Call the method to convert image to text
        await _convertImageToText(imageUrl);
      } else {
        throw Exception('No documents found in Firestore');
      }
    } catch (error) {
      print('Error fetching data from Firestore: $error');
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _convertImageToText(String imageUrl) async {
    try {
      final response = await http.get(
        Uri.parse('https://ocr-extract-text.p.rapidapi.com/ocr?url=${Uri.encodeFull(imageUrl)}'),
        headers: {
          'X-Rapidapi-Key': '07cff6d50amsh4414fb9b5bc4e4cp16efbbjsn9ca505e1c6ea',
          'X-Rapidapi-Host': 'ocr-extract-text.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          convertedText = data['text'];
          loading = false;
        });
      } else {
        throw Exception('Failed to convert image to text');
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converted Text'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        widthFactor: double.maxFinite,
        child: loading
            ? CircularProgressIndicator()
            : convertedText != null
                ? Text(convertedText!)
                : Text('Failed to convert image to text'),
      ),
    );
  }
}
