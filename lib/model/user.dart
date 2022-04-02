// user datas fetched from github

class User{
  String name;
  String avatarUrl; //html_url
  String email;

  User({required this.name, required this.avatarUrl, required this.email});

  // factory is ignored to check provider state management

 /* factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json ['name'],
      avatarUrl: json['avatar_url'],
      email: json['email'],
    );
  } */
}
