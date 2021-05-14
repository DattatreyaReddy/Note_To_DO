import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/note_controller.dart';
import 'utils/note_utils.dart';

class NoteView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetX<NoteController>(
        //autoRemove: false,
        //assignId: false,
        init: NoteController(),
        // initState: (state){ Get.find<NoteController>().obj = 'fast code get snittpets' ;},
        builder: (_) {
          return _.notes.isEmpty
              ? Center(child: Text('Click " + " buttton to take a Notes '))
              : RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(Duration(milliseconds: 500), () {
                      _.reloadNotes();
                    });
                  },
                  child: ListView.builder(
                    itemCount: _.notes.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        onDismissed: (direction) {
                          direction == DismissDirection.endToStart
                              ? _.removeNote(_.notes[index])
                              : editNote(note: _.notes[index]);
                        },
                        direction: DismissDirection.horizontal,
                        background: Container(
                          color: Colors.green,
                          child: Align(
                            alignment: Alignment(-0.9, 0),
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: Align(
                            alignment: Alignment(0.9, 0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        key: UniqueKey(),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              viewNote(note: _.notes[index]);
                            },
                            title: Text(_.notes[index].title!),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _.notes[index].description!,
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
