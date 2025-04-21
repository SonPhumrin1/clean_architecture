import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailPage extends ConsumerWidget {
  final int postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
