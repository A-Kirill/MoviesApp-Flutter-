import 'package:flutter/material.dart';
import 'package:movies_fltr/blocs/image_bloc/image_bloc.dart';
import 'package:movies_fltr/models/models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageList extends StatefulWidget {
  final int imageId;

  const ImageList({Key? key, required this.imageId}) : super(key: key);

  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  final ImageBloc _imageBloc = ImageBloc();

  @override
  void initState() {
    super.initState();
    _imageBloc.add(GetImageList(widget.imageId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocProvider(
        create: (_) => _imageBloc,
        child: BlocBuilder<ImageBloc, ImageState>(builder: (context, state) {
          if (state is ImageInitial) {
            return _buildLoading();
          } else if (state is ImageLoading) {
            return _buildLoading();
          } else if (state is ImageLoaded) {
            return _buildCarouselSlider(state);
          } else if (state is ImageError) {
            return Container();
          } else {
            return Container();
          }
        }),
      ),
    );
  }

  CarouselSlider _buildCarouselSlider(ImageLoaded state) {
    return CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
        items: imageSliders(listImages(state.image)));
  }

  List<String> listImages(List<Images> images) {
    return images.map((obj) => obj.previewUrl).toList();
  }

  List<Widget> imageSliders(List<String> list) {
    return list
        .map((item) => Container(
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
            ))
        .toList();
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
