import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String id;
  final String title;
  final String content;

  const PostEntity({
    required this.id,
    required this.title,
    required this.content,
  });

  @override
  List<Object?> get props => [id, title, content];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }
}
