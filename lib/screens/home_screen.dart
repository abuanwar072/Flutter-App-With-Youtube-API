import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map/constants.dart';
import 'package:map/models/Video.dart';

import 'package:http/http.dart' as http;

import 'components.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Video>> futureVideos;
  @override
  void initState() {
    futureVideos = fetchVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Flutter Way"),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: FutureBuilder<List<Video>>(
          future: futureVideos,
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(
                  clipBehavior: Clip.none,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      VideoCard(video: snapshot.data![index]),
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}

Future<List<Video>> fetchVideos() async {
  final response = await http.get(Uri.parse(
      'https://www.googleapis.com/youtube/v3/search?key=$apiKey&channelId=$channelId&part=snippet,id&order=date&maxResults=20'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print(jsonDecode(response.body)['items']);
    Iterable items = jsonDecode(response.body)['items'];
    List<Video> videos = items.map((video) => Video.fromJson(video)).toList();
    return videos;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
