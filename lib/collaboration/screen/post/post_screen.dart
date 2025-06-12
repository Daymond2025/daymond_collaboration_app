import 'package:cached_network_image/cached_network_image.dart';
import 'package:daymond_collaboration_app/collaboration/OnboardingSceen.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/bottomNavigationBar/BottomTabbarRecruteur.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/post_model.dart';
import 'package:daymond_collaboration_app/collaboration/screen/post/single_post_screen.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_post.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  bool _loading = false;
  bool noCnx = false;

  List<dynamic> _posts = [];

  Future<void> postes() async {
    ApiResponse response = await getPosts();
    if (response.error == null) {
      // print(response.data);
      setState(() {
        _posts = response.data as List<dynamic>;
        // print(_posts);
        _loading = true;
        noCnx = false;
      });
    } else if (response.error == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (route) => false);
      user_services.logout();
    } else {
      setState(() {
        noCnx = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    postes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: const Text(
            'Chaîne',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          actions: [],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            _loading = false;
          });
          return postes();
        },
        child: Container(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 12,
            right: 3,
          ),
          child: _loading
              ? _posts.isNotEmpty
                  ? ListView.builder(
                      itemCount: _posts.length,
                      itemBuilder: (context, index) {
                        PostModel postModel = PostModel.fromJson(_posts[index]);
                        // print(postModel);
                        return Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 12,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                92,
                                        height: 2,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        width: 85,
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(
                                          '${postModel.createdAtFr}',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(
                                    left: 12,
                                    right: 12,
                                    bottom: 12,
                                  ),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(18),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      top: 5,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 0, top: 5),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Stack(
                                            children: [
                                              Container(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  postModel.title!,
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        postModel.description != null
                                            ? Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  postModel.description!,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${postModel.picturePath}',
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 7),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: kLikeEtComment(
                                                    postModel.likesCount! ?? 0,
                                                    postModel.liked! > 0
                                                        ? Icons.thumb_up
                                                        : Icons
                                                            .thumb_up_outlined,
                                                    postModel.liked! > 0
                                                        ? Colors.blue
                                                        : Colors.black38, () {
                                                  _handlePostLikeNo(
                                                      postModel.id ?? 0);
                                                }),
                                              ),
                                              SizedBox(width: 5),
                                              Expanded(
                                                child: kLikeEtComment(
                                                    postModel.commentsCount ??
                                                        0,
                                                    Icons.sms_outlined,
                                                    Colors.black54, () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PostScreen(
                                                        postId: postModel.id!,
                                                        image: postModel
                                                            .picturePath!,
                                                        body: postModel.title ??
                                                            '',
                                                        description: postModel
                                                                .description ??
                                                            '',
                                                        heure: postModel
                                                            .createdAtFr!,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                              postModel.url != null
                                                  ? SizedBox(width: 5)
                                                  : Container(),
                                              postModel.url != null
                                                  ? Expanded(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          String url =
                                                              postModel.url;
                                                          await canLaunch(url)
                                                              ? launch(url)
                                                              : print(
                                                                  'Youtue non ouvert');
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 6),
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .blueAccent,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                          child: Text(
                                                            'Voir plus',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      })
                  : const Center(
                      child: Text('Pas d\'actualité!'),
                    )
              : const Center(
                  child: CircularProgressIndicator(
                  color: Colors.blue,
                )),
        ),
      ),
      bottomNavigationBar: BottomTabbarRecruteur(
        selectedIndex: 3,
      ),
    );
  }

  Container kChargement() => Container(
        padding: const EdgeInsets.all(10),
        child: Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 255, 255, 255),
          highlightColor: const Color.fromARGB(255, 252, 242, 242),
          child: Container(
            height: 240,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
          ),
        ),
      );

  GestureDetector kLikeEtComment(
      int value, IconData icon, Color color, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: color,
            ),
            Text('$value'),
          ],
        ),
      ),
    );
  }

  void _handlePostLikeNo(int postId) async {
    ApiResponse response = await likeNo(postId);

    if (response.error == null) {
      postes();
    } else if (response.error == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (route) => false);
      user_services.logout();
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }
}
