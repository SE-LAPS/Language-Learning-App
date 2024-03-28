import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final List<Post> _posts = [
    Post(
      username: 'User1',
      content:
          'Hello everyone! I\'m new to this language learning app. Can anyone share some tips for beginners?',
      replies: [],
    ),
    Post(
      username: 'User2',
      content:
          'I\'ve been using this app for a few weeks now, and I really like the interactive lessons. The quizzes help reinforce what I\'ve learned.',
      replies: [
        Reply(
          username: 'User3',
          content: 'Agreed! The quizzes are really helpful.',
        ),
      ],
    ),
  ];

  final TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Forum'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return PostCard(
                  post: _posts[index],
                  onReply: (reply) {
                    setState(() {
                      _posts[index].replies.add(reply);
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _postController,
              decoration: InputDecoration(
                hintText: 'Write a new post...',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_postController.text.isNotEmpty) {
                      setState(() {
                        _posts.add(
                          Post(
                            username: 'You',
                            content: _postController.text,
                            replies: [],
                          ),
                        );
                        _postController.clear();
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final Post post;
  final ValueChanged<Reply> onReply;

  const PostCard({
    super.key,
    required this.post,
    required this.onReply,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final TextEditingController _replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.username,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(widget.post.content),
            const SizedBox(height: 8.0),
            ...widget.post.replies.map((reply) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reply.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(reply.content),
                    const SizedBox(height: 8.0),
                  ],
                ),
              );
            }),
            TextField(
              controller: _replyController,
              decoration: InputDecoration(
                hintText: 'Write a reply...',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_replyController.text.isNotEmpty) {
                      widget.onReply(
                        Reply(
                          username: 'You',
                          content: _replyController.text,
                        ),
                      );
                      _replyController.clear();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Post {
  final String username;
  final String content;
  List<Reply> replies;

  Post({
    required this.username,
    required this.content,
    required this.replies,
  });
}

class Reply {
  final String username;
  final String content;

  Reply({
    required this.username,
    required this.content,
  });
}