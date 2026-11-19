import 'package:base_flutter/features/posts/domain/entities/post.dart';
import 'package:material_ui/material_ui.dart';

class PostTile extends StatelessWidget {
  const PostTile({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(
        post.title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        post.body,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
