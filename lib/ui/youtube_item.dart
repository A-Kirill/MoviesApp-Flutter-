import 'package:movies_fltr/ui/separator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class YoutubeItem extends StatefulWidget {
  final Video video;

  const YoutubeItem({Key? key, required this.video}) : super(key: key);

  @override
  _YoutubeItemState createState() => _YoutubeItemState();
}

class _YoutubeItemState extends State<YoutubeItem> {
  late String? videoId;
  late YoutubePlayerController _controller;

  @override
  initState() {
    super.initState();

    videoId = YoutubePlayer.convertUrlToId(widget.video.url);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16 / 10,
        child: Column(
          children: [
            YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
              ),
              builder: (context, player) {
                return player;
              },
            ),
            const Separator()
          ],
        ),
    );
  }
}
