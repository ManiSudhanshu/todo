import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/task.dart';

class CarouselPage extends StatefulWidget {
  const CarouselPage({Key? key}) : super(key: key);
  static const id = 'CarouselPage';

  @override
  State<CarouselPage> createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  int _current = 0;
  final List<String> texts = [
    'Text 1 ',
    'Text 2',
    'Text 3',
    'Text 4',
    'Text 5'
  ];
  final CarouselController _controller = CarouselController();

  List<String> items = [
    'https://media.istockphoto.com/photos/woman-hand-holding-cellphone-with-empty-screen-on-white-background-picture-id1294325965?b=1&k=20&m=1294325965&s=170667a&w=0&h=rQWe3BR4tCNbhkuiR-zGa0tsFUv0OYd70Y_mZvIpV-w=',
    'https://img.freepik.com/free-photo/phone-grey-background_125540-782.jpg?size=626&ext=jpg',
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
    '',
  ];

  List<Widget> getItems() {
    List<Widget> wid = [];
    for (int i = 0; i < items.length; i++) {
      if (i < 3) {
        wid.add(Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  texts[_current],
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black87,
                child: Image.network(
                  items[i],
                  fit: BoxFit.contain,
                ),
              ),
            )
          ],
        ));
      } else {
        wid.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Sign up to the newsletter, and \n unlock a theme for your list.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                    const Expanded(
                      flex: 2,
                      child: Icon(
                        Icons.message,
                        size: 150,
                        color: Colors.black45,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter a search term'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 40),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                child: const Text(
                                  'Skip',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.popAndPushNamed(
                                          context, Task.id);
                                    },
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(color: Colors.black54),
                                    )))
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        ));
      }
    }

    return wid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: <Widget>[
          CarouselSlider(
            items: getItems(),
            carouselController: _controller,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              onPageChanged: (index, resaon) {
                setState(() {
                  _current = index;
                });
              },
              autoPlay: false,
              enlargeCenterPage: false,
              viewportFraction: 1,
              aspectRatio: 1,
              initialPage: 0,
            ),
          ),
          if (_current < 3)
            Positioned(
              child: Center(
                child: SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: items.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
          else
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 70,
              child: Center(
                child: SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: items.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
