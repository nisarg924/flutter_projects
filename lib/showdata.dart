import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Show Data"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ListView.builder(itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text("${index + 1}"),
                  ),
                  title: Text("${snapshot.data!.docs[index]["title"]}"),
                  subtitle:Text("${snapshot.data!.docs[index]["description"]}"),
                );
              },
                  itemCount:snapshot.data!.docs.length);
            }
            else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.hasError.toString()}"),);
            }
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
          return Text("empty");
        },
      ),
    );
  }
}