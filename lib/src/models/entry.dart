class Entry {
  final String entryId;
  final String date;
  final String entry;

  Entry({this.entryId, this.date, this.entry});

  //use this when creating an entry from a json object
  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      date: json['date'],
      entry: json['entry'],
      entryId: json['entryId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'entryId': entryId, 'date': date, 'entry': entry};
  }
}
