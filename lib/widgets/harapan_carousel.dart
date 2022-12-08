import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HarapanCarousel extends StatefulWidget {
  HarapanCarousel({super.key});

  @override
  State<HarapanCarousel> createState() => _HarapanCarouselState();
}

class _HarapanCarouselState extends State<HarapanCarousel> {
  CarouselController buttonCarouselController = CarouselController();

  final importedImages = [
    'https://www.london.ac.uk/sites/default/files/styles/max_1300x1300/public/2018-07/nelson-lc-mandela-day.jpg?itok=gPOR6fdZ',
    'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1557392586/gbsflphemfgavkf4y3il.jpg',
    'https://cdn-2.tstatic.net/manado/foto/bank/images/mendiang-munir-said-thalib-aktivis-indonesia323453.jpg'
  ];

  int _currentIndex = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) => Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CarouselSlider(
            items: importedImages.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(1.0),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(i, fit: BoxFit.fill)),
                    ),
                  );
                },
              );
            }).toList(),
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              initialPage: 2,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: map<Widget>(importedImages, (index, url) {
              return Container(
                width: 10.0,
                height: 10.0,
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.black : Colors.grey,
                ),
              );
            }),
          ),
        ),
      ]);
}
