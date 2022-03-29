// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' as rive;

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  rive.SMIInput<bool>? _playButtonInput;
  rive.Artboard? _playButtonArtboard;

  void _playPauseButtonAnimation() {
    if (_playButtonInput?.value == false &&
        _playButtonInput?.controller.isActive == false) {
      _playButtonInput?.value = true;
    } else if (_playButtonInput?.value == true &&
        _playButtonInput?.controller.isActive == false) {
      _playButtonInput?.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    // _prevButtonController = OneShotAnimation(
    //   'onPrev',
    //   autoplay: false,
    // );

    rootBundle.load('Assets/rivanime.riv').then((data) {
      final file = rive.RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller = rive.StateMachineController.fromArtboard(
        artboard,
        'liked',
      );
      if (controller != null) {
        artboard.addController(controller);
        _playButtonInput = controller.findInput('tapped');
      }
      setState(
        () => _playButtonArtboard = artboard,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _playButtonArtboard == null
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                          height: 230,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            'Assets/icn_food.png',
                            fit: BoxFit.fill,
                          )),
                      SizedBox(
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 15, right: 15, left: 15),
                              child: InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                  )),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colors.black38,
                                    Colors.black38
                                  ])),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                    child: Text(
                                      // 'asdasd asdasdas dasdasdasd asdasdasd asda dasdasda sdasdasdasd asdasda ',
                                      "Profile",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                        'Assets/user.png',
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 340.0, bottom: 80),
                        child: SizedBox(
                          child: GestureDetector(
                            onTap: () => _playPauseButtonAnimation(),
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: rive.Rive(
                                artboard: _playButtonArtboard!,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
  }
}
