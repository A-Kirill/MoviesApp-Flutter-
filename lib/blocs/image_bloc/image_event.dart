part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class GetImageList extends ImageEvent {
  final int id;

  const GetImageList(this.id);
}
