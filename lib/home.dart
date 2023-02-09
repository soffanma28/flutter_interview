import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Post.dart';
import 'package:flutter_application_1/detail.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  const CustomListItemTwo({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
  });

  final Widget thumbnail;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _HomePageState extends State<HomePage> {
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter app')),
        body: Center(
          child: FutureBuilder(
            builder: (context, AsyncSnapshot<List<Post>> snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return ListTile(
                      //   leading: CircleAvatar(
                      //     backgroundImage:
                      //         NetworkImage('${snapshot.data?[index].image}'),
                      //   ),
                      //   title: Text('${snapshot.data?[index].title}'),
                      //   subtitle: Text('${snapshot.data?[index].short_text}'),
                      // );
                      return GestureDetector(
                        onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                                id: snapshot.data![index].id),
                          ),
                        );
                      },
                        child: CustomListItemTwo(
                          thumbnail: Image.network('${snapshot.data?[index].image}'),
                          title: '${snapshot.data?[index].title}',
                          subtitle: '${snapshot.data?[index].short_text}',
                          // author: 'Dash',
                          // publishDate: 'Dec 28',
                          // readDuration: '5 mins',
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Something went wrong :('));
              }

              return CircularProgressIndicator();
            },
            future: posts,
          ),
        ),
      ),
    );
  }
}

Future<List<Post>> fetchPosts() async {
  final response =
      await http.get(Uri.parse('https://sample-api.myalkes.com/api/v1/posts'));

  if (response.statusCode == 200) {
    var topPostsJson = jsonDecode(response.body)['posts'] as List;
    return topPostsJson.map((post) => Post.fromJson(post)).toList();
  } else {
    throw Exception('Failed to load Posts');
  }
}