part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object?> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final List<Images> image;
  const ImageLoaded(this.image);
}

class ImageError extends ImageState {
  final String? message;
  const ImageError(this.message);
}