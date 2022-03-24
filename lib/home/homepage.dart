import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

CollectionReference noteref = FirebaseFirestore.instance.collection('notes');

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الصفحة الرئيسية'),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed("login");
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed("addnotes");
            }),
        body: Container(
          child: FutureBuilder(
            future: noteref
                .where('userid',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, i) {
                      return ListNotes(Note: snapshot.data!.docs[i]);
                    });
              } else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        ),
      ),
    );
  }
}

class ListNotes extends StatelessWidget {
  final Note;
  ListNotes({required this.Note});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Image.network(
            "${Note['imageurl']}",
            fit: BoxFit.fill,
            height: 80,
          ),
        ),
        Expanded(
          flex: 3,
          child: ListTile(
            title: Text("${Note['title']}"),
            subtitle: Text(
              "${Note['note']}",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ],
    ));
  }
}
