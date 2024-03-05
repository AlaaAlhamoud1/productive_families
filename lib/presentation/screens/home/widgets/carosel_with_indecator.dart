import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:productive_families/data/models/ads_model.dart';

class CarouselWithIndicatorWidget extends StatefulWidget {
  final List<AdsModel?> adsModels;
  final Color indicatorsColor;

  const CarouselWithIndicatorWidget(
      {Key? key, required this.adsModels, required this.indicatorsColor})
      : super(key: key);

  @override
  State<CarouselWithIndicatorWidget> createState() =>
      _CarouselWithIndicatorWidgetState();
}

class _CarouselWithIndicatorWidgetState
    extends State<CarouselWithIndicatorWidget> {
  bool play = false;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CarouselSlider(
              items: List.generate(
                widget.adsModels.length,
                (i) => FutureBuilder<String>(
                    future: getImageUrl(widget.adsModels[i]!.image!),
                    builder: (context, snapshot) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: widget.adsModels[i]!.image == null
                            ? Image.asset(
                                'assets/images/broken_image.png',
                                fit: BoxFit.contain,
                              )
                            : Image.network(
                                snapshot.data ?? "",
                                fit: BoxFit.contain,
                                width: double.infinity,
                                errorBuilder: (context, exception, stackTrace) {
                                  return Image.asset(
                                    'assets/images/broken_image.png',
                                    fit: BoxFit.contain,
                                  );
                                },
                              ),
                      );
                    }),
              ),
              options: CarouselOptions(
                autoPlayInterval: const Duration(seconds: 3),
                // onPageChanged: (index, reason) {
                //   setState(() {
                //     currentIndex = index;
                //   });
                // },
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<String> getImageUrl(String imagePath) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child(imagePath);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print("Error getting image URL: $e");
      return "";
    }
  }
}
