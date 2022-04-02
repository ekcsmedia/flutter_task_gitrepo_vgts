class Orgs{
  String url;
  String description;

  Orgs({required this.url, required this.description});

  factory Orgs.fromJson(Map<String, dynamic> json) {
    return Orgs(
      url: json ['url'],
      description: json['description'],
    );
  }
}

class All{
  List<Orgs> orgs;
  All({required this.orgs});

  factory All.fromJson(List<dynamic> json) {
    List<Orgs> orgs = <Orgs>[];
    orgs = json.map((r) => Orgs.fromJson(r)).toList();
    return All(orgs: orgs);
  }
}