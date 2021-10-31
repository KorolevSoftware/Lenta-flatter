import 'package:artstation/models/models.dart';
import 'package:artstation/screens/screens.dart';
import 'package:artstation/widgets/widgets.dart';
import 'package:artstation/extensions/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostView extends StatelessWidget {
  final Post post;
  final bool isLiked;
  final VoidCallback onLike;
  final bool recentlyLiked;

  const PostView({
    Key key,
    @required this.post,
    @required this.isLiked,
    @required this.onLike,
    this.recentlyLiked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card (
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.all(10),
      color: Colors.grey[850],
      shadowColor: Colors.blueGrey,
      child:Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
              ProfileScreen.routeName,
              arguments: ProfileScreenArgs(userId: post.author.id),
            ),
            child: Row(
              children: [
                UserProfileImage(
                  radius: 18.0,
                  profileImageUrl: post.author.profileImageUrl,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Container( child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [Text(
                    post.author.username,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                        color: Colors.white,
                    ),
                  ),
                      Text(
                        post.date.timeAgo(),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),],
                  ),
                  ),
                ),
                IconButton(
                  icon: isLiked
                      ? const Icon(Icons.favorite, color: Colors.lightGreen)
                      : const Icon(Icons.favorite_outline, color: Colors.white),
                  onPressed: onLike,
                ),
                Text(
                  '${recentlyLiked ? post.likes + 1 : post.likes} likes',
                  style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                ),],
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: onLike,
          child: Container(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
              height: MediaQuery.of(context).size.height / 2.25,
              width: double.infinity,
              imageUrl: post.imageUrl,
              fit: BoxFit.cover,
            ),
        ),
        ),
        ),
        const SizedBox(height: 20,)
      ],
    ),
    );

  }
}
