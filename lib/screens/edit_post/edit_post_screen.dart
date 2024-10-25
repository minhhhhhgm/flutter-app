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
                  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7Il9pZCI6IjY3MDY0MTkxN2Y4OTAwMTUxODcyMTc3ZSIsIm5hbWUiOiJvYyBjaMOzIDIiLCJwYXNzd29yZCI6IiQyYiQxMCQxQmlJV21LOUZhMGZxWmVIeFgzN3Uubmxyb245dEU3REhMRk1pQ3F6QkU4RmJOZ1pTMnNCVyIsImVtYWlsIjoib2MxQGV4YW1wbGUuY29tIiwiZGV2aWNlc1Rva2VuIjpbXSwiZm9sbG93ZXJzIjpbIjY3MDY1N2ZhN2Y4OTAwMTUxODcyMTc5OCJdLCJmb2xsb3dpbmciOltdLCJjcmVhdGVkQXQiOiIyMDI0LTEwLTA5VDA4OjQwOjQ5LjgyMloiLCJ1cGRhdGVkQXQiOiIyMDI0LTEwLTExVDEwOjA2OjIyLjY0OVoiLCJfX3YiOjB9LCJpYXQiOjE3Mjk0OTE1MjQsImV4cCI6MTczMDM1NTUyNH0.Vuaovk9qV8fDgS3aVly6agUCb1HIy7wUCcFJrDSHHZE"
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
