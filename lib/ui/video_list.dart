import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../models/video_response.dart';
import '../network/api_service.dart';
import 'youtube_item.dart';

class VideoList extends StatefulWidget {
  final int movieId;

  const VideoList({Key? key, required this.movieId}) : super(key: key);

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late Future<List<Video>> futureVideos;
  late ApiService service;

  @override
  void initState() {
    super.initState();
    service = ApiService();
    futureVideos = getVideosBy(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(),
      body: FutureBuilder<List<Video>>(
        future: futureVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(child: Text(translate('common.no_video'),
                style: const TextStyle(color: Colors.white),));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                List<Video> videoList = snapshot.data!;
                  return YoutubeItem(video: videoList[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<Video>> getVideosBy(int id) async {
    return await service.getVideoFor(id);
  }
}
