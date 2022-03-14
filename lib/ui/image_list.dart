import 'package:flutter/material.dart';
import 'package:movies_fltr/models/images_response.dart';
import 'package:movies_fltr/network/api_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageList extends StatefulWidget {
  final int imageId;
  const ImageList({Key? key, required this.imageId}) : super(key: key);

  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  late Future<List<Images>> futureImages;
  late ApiService service;

  @override
  void initState() {
    service = ApiService();
    futureImages = getImagesBy(widget.imageId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<List<Images>>(
        future: futureImages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                items: imageSliders(listImages(snapshot.data!))
              );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  List<String> listImages(List<Images> images) {
    return images.map((obj) => obj.previewUrl).toList();
  }

  List<Widget> imageSliders(List<String> list) {
    return list.map((item) => Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: CachedNetworkImage(
          imageUrl: item,
          width: 1000,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    )).toList();
  }

  Future<List<Images>> getImagesBy(int id) async {
    return await service.getImagesFor(id);
  }
}
