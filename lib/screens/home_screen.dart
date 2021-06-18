import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:map/components/video_card_shimmer.dart';
import 'package:map/constants.dart';
import 'package:map/models/Video.dart';

import 'package:http/http.dart' as http;

import 'components/video_card.dart';

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
              : ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => VideoCardShimmer(),
                ),
        ),
      ),
    );
  }
}

Future<List<Video>> fetchVideos() async {
  final response = await http.get(Uri.parse(
      'https://www.googleapis.com/youtube/v3/search?key=$apiKey&channelId=$channelId&part=snippet,id&order=date&maxResults=15'));

  if (response.statusCode == 200) {
    Iterable items = jsonDecode(response.body)['items'];
    List<Video> videos = items.map((video) => Video.fromJson(video)).toList();
    return videos;
  } else {
    throw Exception('Failed to load');
  }
}
