import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_fltr/network/api_repository.dart';
import 'package:movies_fltr/models/models.dart';

part 'video_event.dart';

part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetVideoList>((event, emit) async {
      try {
        emit(VideoLoading());
        final mList = await _apiRepository.getVideoFor(event.id);
        emit(VideoLoaded(mList));
      } on NetworkError {
        emit(const VideoError("Failed to fetch videos."));
      }
    });
  }
}
