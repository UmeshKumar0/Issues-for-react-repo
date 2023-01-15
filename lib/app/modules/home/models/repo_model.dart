class RepoModel {
  String? url;
  int? number;
  String? title;
  User? user;
  List<Labels>? labels;
  String? state;
  int? comments;
  String? createdAt;
  String? body;

  RepoModel({
    this.url,
    this.number,
    this.title,
    this.user,
    this.labels,
    this.state,
    this.comments,
    this.createdAt,
    this.body,
  });

  RepoModel.fromJson(Map<String, dynamic> json) {
    url = json['html_url'];

    number = json['number'];
    title = json['title'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['labels'] != null) {
      labels = <Labels>[];
      json['labels'].forEach((v) {
        labels!.add(new Labels.fromJson(v));
      });
    }
    state = json['state'];
    comments = json['comments'];
    createdAt = json['created_at'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['html_url'] = this.url;

    data['number'] = this.number;
    data['title'] = this.title;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.labels != null) {
      data['labels'] = this.labels!.map((v) => v.toJson()).toList();
    }
    data['state'] = this.state;
    data['comments'] = this.comments;
    data['created_at'] = this.createdAt;
    data['body'] = this.body;
    return data;
  }
}

class User {
  String? login;
  int? id;

  User({this.login, this.id});

  User.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    return data;
  }
}

class Labels {
  String? name;
  String? color;
  String? description;

  Labels({this.name, this.color, this.description});

  Labels.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    data['description'] = this.description;
    return data;
  }
}
