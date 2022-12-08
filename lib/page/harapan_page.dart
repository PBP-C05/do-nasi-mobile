import 'package:do_nasi/widgets/harapan_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HarapanPage extends StatefulWidget {
  const HarapanPage({super.key});

  @override
  State<HarapanPage> createState() => _HarapanPageState();
}

class _HarapanPageState extends State<HarapanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harapan'),
      ),
      body: Center(child: Column(children: [HarapanCarousel()])),
    );
  }
}
