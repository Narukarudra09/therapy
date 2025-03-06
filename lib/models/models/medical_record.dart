class MedicalRecord {
  final String id;
  final String title;
  final String date;
  final String fileUrl;

  MedicalRecord({
    required this.id,
    required this.title,
    required this.date,
    required this.fileUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'fileUrl': fileUrl,
    };
  }

  factory MedicalRecord.fromMap(Map<String, dynamic> map) {
    return MedicalRecord(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      fileUrl: map['fileUrl'] ?? '',
    );
  }
}
