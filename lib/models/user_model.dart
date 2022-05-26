class userModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? bio;
  String? profileimage;
  String? coverimage;

  userModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.bio,
    this.profileimage,
    this.coverimage,
  });

  userModel.FromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    bio = json['bio'];
    uId = json['uId'];
    profileimage = json['profileimage'];
    coverimage = json['coverimage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'bio': bio,
      'profileimage': profileimage,
      'coverimage': coverimage,
    };
  }
}
