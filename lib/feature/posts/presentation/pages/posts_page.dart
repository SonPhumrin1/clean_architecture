import 'package:clean_architecture/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/posts_provider.dart';

class PostsPage extends ConsumerWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsyncValue = ref.watch(postsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => const CreatePostRoute().push(context),
          ),
        ],
      ),
      body: postsAsyncValue.when(
        data: (posts) {
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.content,
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  onTap: () {
                    PostDetailRoute(postId: post.id.toString()).push(context);
                  });
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Error: ${error.toString()}')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.read(postsNotifierProvider.notifier).refreshPosts(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
