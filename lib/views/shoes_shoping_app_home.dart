import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoesShopHome extends StatefulWidget {
  const ShoesShopHome({super.key});

  @override
  State<ShoesShopHome> createState() => _ShoesShopHomeState();
}

class _ShoesShopHomeState extends State<ShoesShopHome> {
  DateTime time = DateTime.now();

  String timeConverter(DateTime currentTime) {
    return '${currentTime.hour}:${currentTime.minute}:${currentTime.second}';
  }

  List<String> categories = [
    'Men Shoes',
    'Women Shoes',
    'Kids Shoes',
  ];

  List<String> images = [
    // 'assets/images/shoe1.webp',
    'assets/images/shoe2.webp',
    'assets/images/sh1.bmp',
    'assets/images/sh2.bmp',
    'assets/images/sh3.bmp',
    'assets/images/sh4.bmp',
  ];

  int currentCatIndex = 0;
  int currentPageIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          width: Get.width, 
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.black,
                    height: Get.height * .25,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Athletic Shoes\nCollection',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                          width: Get.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return TextButton(
                                onPressed: () {
                                  setState(() {
                                    currentCatIndex = index;
                                  });
                                },
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    // color: Colors.white,
                                    color: index == currentCatIndex
                                        ? Colors.white
                                        : Colors.grey[700],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 385,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 30, left: 10),
                          width: Get.width * .8,
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 15),
                            color: Colors.white,
                            elevation: 7,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Spacer(),
                                      IconButton(
                                        icon: const Icon(Icons.heart_broken),
                                        onPressed: () {},
                                      ),
                                      const SizedBox(width: 16),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 150,
                                    width: 300,
                                    child: Image.asset(
                                      // 'assets/images/shoe1.webp',
                                      images[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Ultraboost\nShoes',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                                // color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "Men's Running",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            SizedBox(
                                              width: Get.width * .8 - 32,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "\$180.00",
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 26,
                                                      // color: Colors.grey,
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                  SizedBox(
                                                    // width: 300,
                                                    child: Row(
                                                      children: [
                                                        Text('Colors'),
                                                        SizedBox(width: 10),
                                                        CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:
                                                              Colors.black,
                                                        ),
                                                        SizedBox(width: 10),
                                                        CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor:
                                                              Colors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Latest Shoes',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Show all',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Icon(Icons.arrow_right),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // padding: const EdgeInsets.only(left: 12, right: 12),
                    height: 95,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 100,
                          height: 100,
                          child: Card(
                            margin: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                            elevation: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(images[index]
                                    // index.isOdd ? images[0] : images[3],
                                    ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minWidth: 30,
                          height: 50,
                          color: 0 == currentPageIndex ? Colors.white24 : null,
                          onPressed: () {
                            setState(() {
                              currentPageIndex = 0;
                            });
                          },
                          child: const Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minWidth: 30,
                          height: 50,
                          color: 1 == currentPageIndex ? Colors.white24 : null,
                          onPressed: () {
                            setState(() {
                              currentPageIndex = 1;
                            });
                          },
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minWidth: 30,
                          height: 50,
                          color: 2 == currentPageIndex ? Colors.white24 : null,
                          onPressed: () {
                            setState(() {
                              currentPageIndex = 2;
                            });
                          },
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minWidth: 30,
                          height: 50,
                          color: 3 == currentPageIndex ? Colors.white24 : null,
                          onPressed: () {
                            setState(() {
                              currentPageIndex = 3;
                            });
                          },
                          child: const Icon(
                            Icons.shopify_rounded,
                            color: Colors.white,
                          ),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minWidth: 30,
                          height: 50,
                          color: 4 == currentPageIndex ? Colors.white24 : null,
                          onPressed: () {
                            setState(() {
                              currentPageIndex = 4;
                            });
                          },
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
