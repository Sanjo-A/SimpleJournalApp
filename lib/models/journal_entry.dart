import 'dart:io';

class JournalEntry{
  String title;
  String review;
  String rating;
  String entryDate = new DateTime.now().toIso8601String();
  JournalEntry({this.title, this.review, this.rating, this.entryDate});
}