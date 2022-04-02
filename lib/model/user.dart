class User{
  String name;
  String avatarUrl; //html_url
  String email;

  User({required this.name, required this.avatarUrl, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json ['name'],
      avatarUrl: json['avatar_url'],
      email: json['email'],
    );
  }
}
