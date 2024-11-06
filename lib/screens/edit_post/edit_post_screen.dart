import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/post_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditPostScreen extends StatelessWidget {
  const EditPostScreen({super.key, required this.postResponse});

  final PostResponse postResponse;

  @override
  Widget build(BuildContext context) {
    final edtPostController = TextEditingController(text: postResponse.content);
    bool isUpdate = false;
    Future<void> editPost() async {
      try {
        final url = Uri.parse('http://10.22.20.8:4000/post/updatePost');
        final response = await http.post(url,
            headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7Il9pZCI6IjY3MDhjZmY3M2MwM2YwZDJiZmMwMDgxNyIsIm5hbWUiOiJvYyBjaMOzIDIiLCJwYXNzd29yZCI6IiQyYiQxMCR4Rnk5NWJoTkNFUjB3a01ZOG5DeHplZkplcmg0Q3hBZXAvM1ZvWmtVLnM5NWxFOXFTbS53UyIsImVtYWlsIjoib2MzQGV4YW1wbGUuY29tIiwiZGV2aWNlc1Rva2VuIjpbXSwiZm9sbG93ZXJzIjpbXSwiZm9sbG93aW5nIjpbXSwiY3JlYXRlZEF0IjoiMjAyNC0xMC0xMVQwNzoxMjo1NS42NTdaIiwidXBkYXRlZEF0IjoiMjAyNC0xMC0xMVQwOTo1NDo0NC4wODZaIiwiX192IjowfSwiaWF0IjoxNzMwNzA3ODYzLCJleHAiOjE3MzE1NzE4NjN9.QiBjBeGdnmjDF5y167MvNk0XUxUQFA1V9ywpb1QSwRQ"
            },
            body: jsonEncode(
                {'id': postResponse.id, 'content': edtPostController.text}));
        if (response.statusCode == 200) {
          isUpdate = true;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Update Success'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          throw Exception(
              'Failed to load posts with status: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
        backgroundColor: Colors.pink,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context,{'isReload' : isUpdate});
          },
          child: const Icon(Icons.chevron_left)),
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16)),
              child: TextFormField(
                controller: edtPostController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.edit),
                  border: InputBorder.none,
                  // hintText: 'Content',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16)),
              child:
                  TextButton(onPressed: editPost, child: const Text('Update')),
            ),
          ],
        ),
      ),
    );
  }
}
