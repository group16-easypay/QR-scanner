import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sm/Scanner/QrScanner.dart';
import 'package:sm/Scanner/Results.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // FirebaseDatabaseListView dblist = FirebaseDatabaseListView(query: query, itemBuilder: itemBuilder)
  FirebaseAuth auth = FirebaseAuth.instance;
  void signOutUser() async {
    await auth.signOut();
    // auth.currentUser.
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan code"),
      ),
      body: Center(
        child: PhysicalModel(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(70),
          elevation: 20,
          child: CircleAvatar(
            radius: 80,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QrReader(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: const Icon(
                Icons.qr_code_scanner_rounded,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      drawer: Container(
        padding: EdgeInsets.zero,
        child: Drawer(
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('Signed in as ${auth.currentUser?.email}'),
                accountEmail: Text("UserId :: ${auth.currentUser?.uid}"),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                onTap: signOutUser,
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app_rounded),
                title: const Text("Quit App"),
                onTap: () => exit(0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
