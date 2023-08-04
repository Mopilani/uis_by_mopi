import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoursesAppView extends StatefulWidget {
  const CoursesAppView({super.key});

  @override
  State<CoursesAppView> createState() => _CoursesAppViewState();
}

class _CoursesAppViewState extends State<CoursesAppView> {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            appBar(),
            searchBar(),
            titleWidget('Category'),
            categoriesList(),
            categoryCoursesList(),
            titleWidget('Popular Course'),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    elevation: .0,
                    minWidth: 200,
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    onPressed: () {},
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categories[index],
                                style: const TextStyle(
                                  // color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${Random().nextInt(100)} Lessons',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '4.5',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.star,
                                        size: 10,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${Random().nextInt(150)}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  // MaterialButton(
                                  //   onPressed: () {},
                                  //   padding: const EdgeInsets.all(0),
                                  //   minWidth: 30,
                                  //   height: 30,
                                  //   color: Colors.blue,
                                  //   shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(10),
                                  //   ),
                                  //   child: const Icon(
                                  //     Icons.add,
                                  //     color: Colors.white,
                                  //     size: 20,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 90,
                          width: Get.width / 2.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Container categoryCoursesList() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return MaterialButton(
            elevation: .0,
            minWidth: 200,
            color: selectedCategory == index ? Colors.grey[100] : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPressed: () {
              setState(() {
                selectedCategory = index;
              });
            },
            child: Row(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 100,
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categories[index],
                        style: const TextStyle(
                          // color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${Random().nextInt(100)} Lessons',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '4.5',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.star,
                                size: 10,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${Random().nextInt(150)}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            padding: const EdgeInsets.all(0),
                            minWidth: 30,
                            height: 30,
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container categoriesList() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(left: 12),
              child: MaterialButton(
                color: selectedCategory == index ? Colors.blue : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: selectedCategory == index
                        ? Colors.transparent
                        : Colors.blue,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selectedCategory = index;
                  });
                },
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color:
                        selectedCategory == index ? Colors.white : Colors.blue,
                  ),
                ),
              ),
            );
          },
        ),
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

  Container appBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: const SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Your',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Design Course',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
            CircleAvatar(
              child: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }

  Container searchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      height: 60,
      child: TextField(
        cursorRadius: const Radius.circular(12),
        decoration: InputDecoration(
          fillColor: Colors.grey[100],
          filled: true,
          hintText: 'Search For Course',
          hintStyle: TextStyle(
            color: Colors.grey[400],
          ),
          suffixIcon: Icon(
            color: Colors.grey[400],
            Icons.search,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
