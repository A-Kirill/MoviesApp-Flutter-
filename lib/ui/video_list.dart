import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_fltr/blocs/video_bloc/video_bloc.dart';

import 'youtube_item.dart';

class VideoList extends StatefulWidget {
  final int movieId;

  const VideoList({Key? key, required this.movieId}) : super(key: key);

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final VideoBloc _videoBloc = VideoBloc();

  @override
  void initState() {
    super.initState();
    _videoBloc.add(GetVideoList(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(),
      body: BlocProvider(
        create: (_) => _videoBloc,
        child: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            if (state is VideoInitial) {
              return _buildLoading();
            } else if (state is VideoLoading) {
              return _buildLoading();
            } else if (state is VideoLoaded) {
              if (state.videos.isEmpty) {
                return _buildNoVideo();
              }
              return _buildVideoList(state);
            } else if (state is VideoError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Center _buildNoVideo() {
    return Center(
        child: Text(
      translate('common.no_video'),
      style: const TextStyle(color: Colors.white),
    ));
  }

  ListView _buildVideoList(VideoLoaded state) {
    return ListView.builder(
      itemCount: state.videos.length,
      itemBuilder: (BuildContext context, int index) {
        return YoutubeItem(video: state.videos[index]);
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
