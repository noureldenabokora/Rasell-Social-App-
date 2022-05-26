class MessageModel {
  String? title;
  String? senderUid;
  String? reciverUid;
  String? date;

  MessageModel({
    this.title,
    this.senderUid,
    this.reciverUid,
    this.date,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    senderUid = json['senderUid'];
    reciverUid = json['reciverUid'];
    date = json['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'senderUid': senderUid,
      'reciverUid': reciverUid,
      'date': date,
    };
  }
}
