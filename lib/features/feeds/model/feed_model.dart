import 'package:noviindus_test_app/features/home/model/home_model.dart';

class FeedModel {
  final int count;
  final String? next;
  final String? previous;
  final List<Results> results;

  FeedModel({
    this.count = 0,
    this.next,
    this.previous,
    this.results = const [],
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List)
          .map((e) => Results.fromJson(e))
          .toList(),
    );
  }
}

class User {
  int? id;
  String? name;
  String? image;

  User({this.id, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
