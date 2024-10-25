import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/post_response.dart';
import 'package:flutter_application_1/screens/detail_post/detail_post_screen.dart';
import 'package:flutter_application_1/screens/edit_post/edit_post_screen.dart';
import 'package:flutter_application_1/widgets/box_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PostResponse>> listPost;

  bool isReload = false;

  Future<List<PostResponse>> getAllPost() async {
    try {
      final url = Uri.parse('http://10.22.20.8:4000/post/getAllPost');
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7Il9pZCI6IjY3MDY0MTkxN2Y4OTAwMTUxODcyMTc3ZSIsIm5hbWUiOiJvYyBjaMOzIDIiLCJwYXNzd29yZCI6IiQyYiQxMCQxQmlJV21LOUZhMGZxWmVIeFgzN3Uubmxyb245dEU3REhMRk1pQ3F6QkU4RmJOZ1pTMnNCVyIsImVtYWlsIjoib2MxQGV4YW1wbGUuY29tIiwiZGV2aWNlc1Rva2VuIjpbXSwiZm9sbG93ZXJzIjpbIjY3MDY1N2ZhN2Y4OTAwMTUxODcyMTc5OCJdLCJmb2xsb3dpbmciOltdLCJjcmVhdGVkQXQiOiIyMDI0LTEwLTA5VDA4OjQwOjQ5LjgyMloiLCJ1cGRhdGVkQXQiOiIyMDI0LTEwLTExVDEwOjA2OjIyLjY0OVoiLCJfX3YiOjB9LCJpYXQiOjE3Mjk0OTE1MjQsImV4cCI6MTczMDM1NTUyNH0.Vuaovk9qV8fDgS3aVly6agUCb1HIy7wUCcFJrDSHHZE"
      });
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        // await Future.delayed(const Duration(seconds: 10));
        return jsonData.map((json) => PostResponse.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load posts with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    listPost = getAllPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Home'),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: getAllPost,
                        child: const Text(
                          'List Post',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/no-image.png'))),
                    child: const Padding(
                      padding: EdgeInsets.all(24.0),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: listPost,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No posts found'));
                  }
                  List<PostResponse> posts = snapshot.data ?? [];
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return Container(
                          height: 200,
                          padding: const EdgeInsetsDirectional.only(bottom: 24),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(context , MaterialPageRoute(builder: (context)=> DetailPostScreen(id: post.id ?? '',))),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image(
                                    image: NetworkImage(post.image ??
                                        'https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/03/anh-meme-hai-2.jpg.webp'),
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: 300,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        overflow: TextOverflow.fade,
                                        post.content ?? '',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    // Spacer(),
                                    
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            final response =
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditPostScreen(
                                                                postResponse:
                                                                    post)));
                                            if (response != null) {
                                              final check =
                                                  response['isReload'];
                                              print('check $check');
                                              if (check == true) {
                                                setState(() {
                                                  listPost = getAllPost();
                                                });
                                              }
                                            }
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
