import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Authenticate.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            // SizedBox(
            //   width: 100,
            //   height: 100,
            //   child: Card(
            //       child: Image.asset(
            //     "images/sm.png",
            //   )),
            // ),
            Positioned(
              top: MediaQuery.of(context).size.height / 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Welcome",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 39,
                        shadows: [
                          const Shadow(
                            color: Colors.black,
                            offset: Offset(1, 1.5),
                            blurRadius: 2,
                          )
                        ],
                        color: Colors.green,
                      ),
                ),
              ),
            ),
            Center(
              child: CircleAvatar(
                radius: 50,
                child: TextButton(
                  style: ButtonStyle(
                    // ignore: prefer_const_constructors
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    mouseCursor: MaterialStateProperty.all(
                      MouseCursor.defer,
                    ),
                    visualDensity: VisualDensity.standard,
                    fixedSize: MaterialStateProperty.all(
                      const Size.square(100.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Authenticate(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: const Text(
                    "Procced",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              child: Transform.rotate(
                origin: Offset(20, MediaQuery.of(context).size.height / 20),
                angle: 10,
                child: PhysicalModel(
                  elevation: 19,
                  color: Colors.transparent,
                  shadowColor: Colors.black,
                  borderRadius: BorderRadius.circular(260),
                  child: Container(
                    // padding: EdgeInsets.only(
                    //   top: MediaQuery.of(context).size.height,
                    // ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.4,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(240)),
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
