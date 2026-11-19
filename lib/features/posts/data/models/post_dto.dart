import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

/// Wire format of a post. Kept separate from the [Post] entity so API
/// changes stay inside the data layer.
@freezed
abstract class PostDto with _$PostDto {
  const factory PostDto({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _PostDto;

  const PostDto._();

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  Post toEntity() => Post(id: id, userId: userId, title: title, body: body);
}
