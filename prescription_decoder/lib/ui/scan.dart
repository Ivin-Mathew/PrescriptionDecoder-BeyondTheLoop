import 'dart:io'; 
import 'package:firebase_storage/firebase_storage.dart'; 
import 'package:image_picker/image_picker.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart'; 

class RealtimeDatabaseInsert extends StatefulWidget { 
  RealtimeDatabaseInsert({Key? key}) : super(key: key); 

  @override
  _RealtimeDatabaseInsertState createState() => _RealtimeDatabaseInsertState();
}

class _RealtimeDatabaseInsertState extends State<RealtimeDatabaseInsert> { 
  var nameController = TextEditingController(); 

  
  final firestore = FirebaseFirestore.instance; 
  File? _image;

  @override
  Widget build(BuildContext context) { 
    return Center( 
      child: Scaffold( 
        appBar: AppBar(
          title: const Text('Upload Prescription'),
        ),
        body: SafeArea( 
          child: SingleChildScrollView( 
            child: Padding( 
              padding: const EdgeInsets.all(20.0), 
              child: Column( 
                children: [  
                  Text("Add Data"), 
                  Container( 
                    height: 150, 
                    width: 300, 
                    decoration: BoxDecoration( 
                      border: Border.all(color: Colors.black), 
                      borderRadius: BorderRadius.circular(20), 
                    ), 
                    child: Center( 
                      child: Column( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                        children: [ 
                          Expanded( 
                            child: Center( 
                              child: _image == null 
                                ? Text('No image selected.') 
                                : _buildImageWidget(), // Use conditional widget based on platform
                            ), 
                          ), 
                          ElevatedButton( 
                            onPressed: () async { 
                              final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                              if (image != null) { 
                                setState(() {
                                  _image = File(image.path); 
                                });
                              } 
                            }, 
                            child: Text('Select image'), 
                          ), 
                        ], 
                      ), 
                    ), 
                  ), 
                  SizedBox( 
                    height: 30, 
                  ), 
                  SizedBox( 
                    height: 50, 
                    child: _image != null
                      ? _buildImageWidget() // Use conditional widget based on platform
                      : Container(), // Placeholder when no image is selected
                  ),
                  SizedBox( 
                    height: 20, 
                  ), 
                  ElevatedButton( 
                    onPressed: () async { 
                      if (_image != null) { 
                        // Your upload logic goes here 
                      } else { 
                        // Show error message if no image is selected 
                        showDialog( 
                          context: context, 
                          builder: (BuildContext context) { 
                            return AlertDialog( 
                              title: Text("Error"), 
                              content: Text("Please select an image."), 
                              actions: [ 
                                TextButton( 
                                  onPressed: () { 
                                    Navigator.of(context).pop(); 
                                  }, 
                                  child: Text("OK"), 
                                ), 
                              ], 
                            ); 
                          }, 
                        ); 
                      } 
                    }, 
                    child: Text( 
                      "Submit Details", 
                    ), 
                    style: ElevatedButton.styleFrom( 
                      backgroundColor: Colors.amber, 
                      shape: RoundedRectangleBorder( 
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ), 
            ), 
          ), 
        ),
      ),
    );
  } 

   Widget _buildImageWidget() {
  if (Platform.isIOS || Platform.isAndroid) {
    // Use Image.file for non-web platforms
    return Image.file(_image!);
  } else {
    // Use Image.network for web platform
    return Image.network(_image!.path);
  }
}

}
