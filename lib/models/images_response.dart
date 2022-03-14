import 'package:json_annotation/json_annotation.dart';
part 'images_response.g.dart';


@JsonSerializable()
class Images {

  Images({
  required this.imageUrl,
  required this.previewUrl,
  });

  String imageUrl;
  String previewUrl;

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}
