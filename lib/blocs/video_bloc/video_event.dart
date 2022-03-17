part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class GetVideoList extends VideoEvent {
  final int id;

  const GetVideoList(this.id);
}
