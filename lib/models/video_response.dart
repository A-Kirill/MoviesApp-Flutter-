import 'package:json_annotation/json_annotation.dart';
part 'video_response.g.dart';


@JsonSerializable()
class Video {
  Video({
    required this.url,
    required this.name,
    required this.site,
  });

  String url;
  String name;
  String site;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
