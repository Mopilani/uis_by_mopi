import 'package:flutter/material.dart';

class CarsShopView extends StatefulWidget {
  const CarsShopView({super.key});

  @override
  State<CarsShopView> createState() => _ShoesShopHomeState();
}

class _ShoesShopHomeState extends State<CarsShopView> {
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
    'assets/images/shoe1.webp',
    'assets/images/shoe2.webp',
    'assets/images/sh1.avif',
    'assets/images/sh2.avif',
    'assets/images/sh3.avif',
    'assets/images/sh4.avif',
  ];
  int currentCatIndex = 0;

  List<String> imagesLinks = [
    'https://cdn.inventoryrsc.com/224271797_649e730a9142d37119d08c40.jpg',
    'https://imageio.forbes.com/specials-images/imageserve/5d3703b3090f4300070d570d/2020-Cadillac-CT5/0x0.jpg?format=jpg&crop=4842,2723,x288,y538,safe&width=960',
    'https://imageio.forbes.com/specials-images/imageserve/5d37038495e0230008f64ec1/2020-Cadillac-CT4-V/0x0.jpg?format=jpg&crop=4561,2565,x569,y347,safe&width=960',
    'https://imageio.forbes.com/specials-images/imageserve/5d35eacaf1176b0008974b54/2020-Chevrolet-Corvette-Stingray/0x0.jpg?format=jpg&crop=4560,2565,x790,y784,safe&width=960',
    'https://imageio.forbes.com/specials-images/imageserve/5d37046395e0230008f64edf/2020-Ford-Mustang-Shelby-GT500/0x0.jpg?format=jpg&crop=2552,1437,x299,y201,safe&width=960',
    'https://imageio.forbes.com/specials-images/imageserve/5d37049295e0230008f64eeb/2020-Kia-Soul-EV/0x0.jpg?format=jpg&crop=4377,2463,x547,y592,safe&width=960',
    'https://imageio.forbes.com/specials-images/imageserve/5d35eb15f1176b0008974b5c/2020-McLaren-GT/0x0.jpg?format=jpg&crop=4800,2701,x512,y602,safe&width=960',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              carView(),
              availableCars(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TOP DEALS',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Text(
                          'More',
                          style: TextStyle(color: Colors.blue),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.blue),
                      ],
                    ),
                  ),
                ],
              ),
              carsView(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox carsView() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imagesLinks.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 230,
            child: Card(
              elevation: .0,
              child: Column(
                children: [
                  // const Placeholder(fallbackHeight: 230),
                  SizedBox(
                    height: 230,
                    // width: 230,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            imagesLinks[index],
                            height: 230,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blue[100],
                          ),
                          child: const Text(
                            'Weakly',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 6, 8, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nissan',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox carView() {
    return SizedBox(
      height: 360,
      child: Card(
        elevation: .0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        r'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
                        fit: BoxFit.cover,
                        width: 55,
                        height: 55,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text('IDR'),
                      const SizedBox(width: 4),
                      const Text(
                        '17.7',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      MaterialButton(
                        elevation: .0,
                        minWidth: 55,
                        height: 55,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: Colors.blue,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  r'https://cdn.inventoryrsc.com/224271797_649e730a9142d37119d08c40.jpg',
                ),
              ),
              // const Placeholder(fallbackHeight: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    children: [
                      Text(
                        'GTR',
                        style: TextStyle(
                          // color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                      Text(
                        'Nissan',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Text(
                          'My Garage',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
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

  SizedBox availableCars() {
    return SizedBox(
      height: 100,
      child: Card(
        elevation: .0,
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Cars',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Long term and start term',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              MaterialButton(
                elevation: .0,
                color: Colors.white,
                height: 60,
                minWidth: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onPressed: () {},
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.blue,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
