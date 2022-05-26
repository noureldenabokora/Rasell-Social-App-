class PostModel {
  String? name;
  String? postImage;
  String? date;
  String? uId;
  String? posttext;
  String? profileimage;

  PostModel({
    this.postImage,
    this.name,
    this.date,
    this.uId,
    this.posttext,
    this.profileimage,
  });

  PostModel.FromJson(Map<String, dynamic> json) {
    name = json['name'];
    postImage = json['postImage'];
    date = json['date'];
    posttext = json['posttext'];
    uId = json['uId'];
    profileimage = json['profileimage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'postImage': postImage,
      'date': date,
      'uId': uId,
      'posttext': posttext,
      'profileimage': profileimage,
    };
  }
}
