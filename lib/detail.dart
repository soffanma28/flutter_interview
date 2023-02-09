import 'package:flutter/material.dart';
import 'package:flutter_application_1/PostDetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatefulWidget {
  final int id;
  DetailPage({Key? key, required this.id})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<PostDetail> post;

  @override
  void initState() {
    super.initState();
    post = fetchPostDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Page')),
      body: Center(
          child: FutureBuilder(
        builder: (context, AsyncSnapshot<PostDetail> snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(snapshot.data!.image),
                  fit: BoxFit.cover
                )
              ),
              child: Column(children: [
                Container(
                  color: Colors.white,
                  child: Text(snapshot.data!.title),
                ),
                Container(
                  color: Colors.white,
                  child: Text(snapshot.data!.content),
                ),
              ]),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
        future: post,
      )),
    );
  }
}

Future<PostDetail> fetchPostDetail(id) async {
  final response = await http
      .get(Uri.parse('https://sample-api.myalkes.com/api/v1/posts/${id}'));

  if (response.statusCode == 200) {
    return PostDetail.fromJson(jsonDecode(response.body)['post']);
  } else {
    throw Exception('Failed to load post');
  }
}