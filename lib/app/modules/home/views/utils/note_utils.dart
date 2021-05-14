import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/style.dart';
import '../../../../data/note_model.dart';
import '../../controllers/note_controller.dart';

Future addNote() {
  NoteController noteController = Get.find<NoteController>();
  String? title;
  String? description;
  return Get.defaultDialog(
    title: "Add a New Note",
    textConfirm: "Add",
    content: Container(
      height: Get.height * .3,
      width: Get.width,
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              decoration: kTextFieldDecoration.copyWith(
                labelText: "Add Note Title",
                errorText: noteController.isEmptyTitle.value
                    ? "Title can't be Empty"
                    : null,
              ),
              onChanged: (value) => title = value,
            ),
            TextField(
              maxLines: 6,
              decoration: kTextFieldDecoration.copyWith(
                labelText: "Add Note Description",
                errorText: noteController.isEmptyDescription.value
                    ? "Description can't be Empty"
                    : null,
              ),
              onChanged: (value) => description = value,
            ),
          ],
        ),
      ),
    ),
    onCancel: () {
      Get.back();
      noteController.isEmptyTitle.value = false;
      noteController.isEmptyDescription.value = false;
    },
    onConfirm: () {
      if (title != null &&
          title!.isNotEmpty &&
          description != null &&
          description!.isNotEmpty) {
        noteController.addNote(
          Note(
            title: title,
            description: description,
            timestamp: DateTime.now().toString(),
          ),
        );

        Get.back();
        noteController.isEmptyTitle.value = false;
        noteController.isEmptyDescription.value = false;
      } else {
        noteController.isEmptyTitle.value = (title == null || title!.isEmpty);
        noteController.isEmptyDescription.value =
            (description == null || description!.isEmpty);
      }
    },
  );
}

Future editNote({required Note note}) {
  NoteController noteController = Get.find<NoteController>();
  String? title = note.title;
  String? description = note.description;
  return Get.defaultDialog(
    title: "Edit the Note",
    textConfirm: "Edit",
    content: Container(
      height: Get.height * .3,
      width: Get.width,
      child: Obx(
        () => Column(
          children: [
            TextFormField(
              initialValue: note.title,
              decoration: kTextFieldDecoration.copyWith(
                labelText: "Add Note Title",
                errorText: noteController.isEmptyTitle.value
                    ? "Title can't be Empty"
                    : null,
              ),
              onChanged: (value) => title = value,
            ),
            TextFormField(
              initialValue: note.description,
              maxLines: 6,
              decoration: kTextFieldDecoration.copyWith(
                labelText: "Edit Note Description",
                errorText: noteController.isEmptyDescription.value
                    ? "Description can't be Empty"
                    : null,
              ),
              onChanged: (value) => description = value,
            ),
          ],
        ),
      ),
    ),
    onCancel: () {
      Get.back();
      noteController.reloadNotes();
      noteController.isEmptyTitle.value = false;
      noteController.isEmptyDescription.value = false;
    },
    onConfirm: () {
      if (title != null &&
          title!.isNotEmpty &&
          description != null &&
          description!.isNotEmpty) {
        noteController.updateNote(
          Note(
            id: note.id,
            title: title,
            description: description,
            timestamp: DateTime.now().toString(),
          ),
        );

        Get.back();
        noteController.isEmptyTitle.value = false;
        noteController.isEmptyDescription.value = false;
      } else {
        noteController.isEmptyTitle.value = (title == null || title!.isEmpty);
        noteController.isEmptyDescription.value =
            (description == null || description!.isEmpty);
      }
    },
  );
}

Future viewNote({required Note note}) {
  DateTime timestamp = DateTime.parse(note.timestamp!);
  return Get.defaultDialog(
    title: note.title!,
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: LimitedBox(
        maxHeight: Get.height * .75,
        child: SingleChildScrollView(child: Text(note.description!)),
      ),
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "${timestamp.year}/${timestamp.month}/${timestamp.day}",
            style: TextStyle(fontSize: 10),
          ),
          Text(
            "${timestamp.hour}: ${timestamp.minute}",
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
    ],
  );
}
