class HomeModel {
  final List<Results> results;
  final List<CategoryDict> categoryDict;
  final bool status;
  final bool next;

  HomeModel({
    this.results = const [],
    this.categoryDict = const [],
    this.status = false,
    this.next = false,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      results: (json['results'] as List)
          .map((e) => Results.fromJson(e))
          .toList(),
      categoryDict: (json['category_dict'] as List)
          .map((e) => CategoryDict.fromJson(e))
          .toList(),
      status: json['status'],
      next: json['next'],
    );
  }
}

class CategoryDict {
  String? id;
  String? title;

  CategoryDict({this.id, this.title});

  CategoryDict.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  
}

class Results {
  int? id;
  String? description;
  String? image;
  String? video;
  List<int>? likes;
  List<Null>? dislikes;
  List<Null>? bookmarks;
  List<int>? hide;
  String? createdAt;
  bool? follow;
  User? user;

  Results({
    this.id,
    this.description,
    this.image,
    this.video,
    this.likes,
    this.dislikes,
    this.bookmarks,
    this.hide,
    this.createdAt,
    this.follow,
    this.user,
  });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    image = json['image'];
    video = json['video'];
    likes = json['likes'].cast<int>();
    hide = json['hide'].cast<int>();
    createdAt = json['created_at'];
    follow = json['follow'];
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
  }

}

class User {
  int? id;
  String? name;
  Null image;

  User({this.id, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}
