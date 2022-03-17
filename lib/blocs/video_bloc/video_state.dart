part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final List<Video> videos;

  const VideoLoaded(this.videos);
}

class VideoError extends VideoState {
  final String? message;

  const VideoError(this.message);
}
