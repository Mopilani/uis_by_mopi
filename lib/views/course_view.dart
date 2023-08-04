import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  List<String> categories = [
    'UI/UX',
    'Coding',
    'Basic UI',
    'Computing',
    'AI',
  ];

  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  imageWidget(),
                  titleWidget('Web Designing'),
                  priceAndRateWidget(),
                  courseFeatures(),
                  descriptions(),
                ],
              ),
            ),
          ),
          bottomBar(),
        ],
      ),
    );
  }

  Padding bottomBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          MaterialButton(
            onPressed: () {},
            padding: const EdgeInsets.all(0),
            elevation: .0,
            minWidth: 45,
            height: 45,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Color.fromARGB(255, 224, 224, 224),
                width: 3,
              ),
            ),
            child: const Icon(
              Icons.close,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: MaterialButton(
              onPressed: () {},
              padding: const EdgeInsets.all(0),
              elevation: .0,
              // minWidth: 200,
              height: 45,
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                // side: const BorderSide(color: Colors.grey),
              ),
              child: const Text(
                'Join Course',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container descriptions() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            r"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              // fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Row courseFeatures() {
    return Row(
      children: [
        courseFeature('Classe', '24'),
        courseFeature('Time', '2 Hours'),
        courseFeature('Seat', '24'),
      ],
    );
  }

  Container priceAndRateWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$25.99',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.blue,
            ),
          ),
          Row(
            children: [
              Text('4.3'),
              Icon(Icons.star, color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox imageWidget() {
    return SizedBox(
      height: 330,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                'https://findstack.com/wp-content/uploads/2021/03/The-Ultimate-List-of-E-Learning-Statistics-1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 30,
            child: MaterialButton(
              color: Colors.blue,
              padding: const EdgeInsets.all(0),
              minWidth: 50,
              height: 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {},
              child: const Icon(
                Ionicons.heart,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget courseFeature(String featureName, String value) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 0, 8),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            featureName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Container titleWidget(String title) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
