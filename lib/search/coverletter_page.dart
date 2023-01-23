//import 'dart:convert';

//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsninja/app_bar.dart';
import 'package:jsninja/common.dart';
//import 'package:jsninja/state/generic_state_notifier.dart';
import 'package:jsninja/drawer.dart';
//import 'package:http/http.dart' as http;

class CoverLettersPage extends ConsumerWidget {
  final TextEditingController searchCtrl = TextEditingController();

  CoverLettersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MyAppBar.getBar(context, ref),
      drawer: (MediaQuery.of(context).size.width < WIDE_SCREEN_WIDTH)
          ? TheDrawer.buildDrawer(context)
          : null,
      body: Container(
          margin: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Add Cover Letter",
                    style: Theme.of(context).textTheme.headline3),
              ),
              ListTile(
                title: Text("Cover Letter 1",
                    style: Theme.of(context).textTheme.headline4),
                subtitle: Text("Cover Letter 2",
                    style: Theme.of(context).textTheme.headline4),
              ),
            ],
          )),
    );
  }
}
