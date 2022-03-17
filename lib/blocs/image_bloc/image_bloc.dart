import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_fltr/network/api_repository.dart';
import 'package:movies_fltr/models/models.dart';

part 'image_event.dart';

part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetImageList>((event, emit) async {
      try {
        emit(ImageLoading());
        final mList = await _apiRepository.getImagesFor(event.id);
        emit(ImageLoaded(mList));
      } on NetworkError {
        emit(const ImageError("Failed to fetch images."));
      }
    });
  }
}
