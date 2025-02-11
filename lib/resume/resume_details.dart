import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jsninja/resume/resume_list.dart';
import 'package:jsninja/resume/user_resume_page.dart';

class ResumeDetails extends ConsumerStatefulWidget {
  final TextEditingController titleCtrl = TextEditingController();

  late final TextEditingController resumeIdCtrl = TextEditingController();
  late final TextEditingController descCtrl = TextEditingController();
  late final TextEditingController bodyCtrl = TextEditingController();

  final Map<String, dynamic>? data;
  ResumeDetails(this.data, {Key? key}) : super(key: key) {
    print('ResumeDetail constructor: ${data}');

    if (data != null) {
      titleCtrl.text = data!['data']['jobTitle'];

      if (data!['data']['description'] != null) {
        descCtrl.text = data!['data']!['description'];
      } else {
        bodyCtrl.text = '';
      }

      if (data!['data']['body'] != null) {
        bodyCtrl.text = data!['data']['body'];
      } else {
        bodyCtrl.text = '';
      }
    }
  }

  @override
  ResumeDetailsState createState() => ResumeDetailsState();
}

class ResumeDetailsState extends ConsumerState<ResumeDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextField(
          // ignore: prefer_const_constructors
          decoration: InputDecoration(
            hintText: "Job title",
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 19, 20, 20)),
            ),
          ),
          autocorrect: true,
          minLines: 1,
          maxLines: 1,
          keyboardType: TextInputType.multiline,
          style: Theme.of(context).textTheme.headline6,
          onChanged: (v) {},
          controller: widget.titleCtrl,
        ),
        TextField(
          decoration: const InputDecoration(
            hintText: "Job Description",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 19, 20, 20)),
            ),
          ),
          autocorrect: true,
          minLines: 3,
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          style: Theme.of(context).textTheme.bodyText2,
          onChanged: (v) {},
          controller: widget.descCtrl,
        ),
        TextField(
          // ignore: prefer_const_constructors
          decoration: InputDecoration(
            hintText: "Resume",
            // ignore: prefer_const_constructors
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  // width: 3,
                  color: Color.fromARGB(255, 19, 20, 20)),
            ),
          ),
          autocorrect: true,
          minLines: 34,
          maxLines: 34,
          scrollPadding: const EdgeInsets.all(20.0),
          keyboardType: TextInputType.multiline,
          style: Theme.of(context).textTheme.bodyText2,
          onChanged: (v) {},
          controller: widget.bodyCtrl,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ElevatedButton(
                // ignore: prefer_const_constructors
                child: Icon(
                  Icons.edit,
                  size: 30,
                ),
                onPressed: () async {
                  print('saving ${ref.read(resumeSNP.notifier).value!['id']}');
                  firestoreInstance
                      .collection("user")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('resume')
                      .doc(ref.read(resumeSNP.notifier).value!['id'])
                      .update({
                    'jobTitle': widget.titleCtrl.text,
                    'description': widget.descCtrl.text,
                    'body': widget.bodyCtrl.text,
                    'lastupdated': Timestamp.now()
                  });
                }),
            const SizedBox(
              width: 10,
            ),

            //delete popup with confirm.
            ElevatedButton(
              child: Icon(
                Icons.delete,
                size: 30,
              ),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Delete the following?'),
                  content: Text(widget.titleCtrl.text.toString()),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        firestoreInstance
                            .collection("user")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("resume")
                            .doc(ref.read(resumeSNP.notifier).value!['id'])
                            .delete();
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
