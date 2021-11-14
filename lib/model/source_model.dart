import 'package:equatable/equatable.dart';

class Source extends Equatable {
  String? id;
  String? name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'], name: json['name']);
  }

  @override
  List<Object?> get props => [id, name];
}
