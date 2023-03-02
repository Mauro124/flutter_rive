import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

import '../providers/avatar_provider/avatar_providers.dart';

class Avatar extends ConsumerStatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  ConsumerState<Avatar> createState() => _AvatarState();
}

class _AvatarState extends ConsumerState<Avatar> {
  SMINumber? _positionX;
  SMINumber? _positionY;
  SMIBool? _happy;
  SMIBool? _sad;
  SMIBool? _uncertain;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 500),
      () => setState(() {
        _positionX?.value = 0;
        _positionY?.value = 0;
        _happy?.value = false;
        _sad?.value = false;
        _uncertain?.value = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    _setEyesPosition();
    _setEmotions();

    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: RiveAnimation.asset(
          'assets/images/more_than_code.riv',
          fit: BoxFit.contain,
          artboard: 'avatar',
          onInit: _onRiveInit,
        ),
      ),
    );
  }

  void _setEmotions() {
    ref.listen<AvatarEmotionState>(emotionStateProvider, (_, state) {
      if (state == AvatarEmotionState.HAPPY) {
        _happy?.value = true;
      } else {
        _happy?.value = false;
      }
      setState(() {});
    });
  }

  void _setEyesPosition() {
    ref.listen<AvatarEyesPositionState>(eyesPositionProviders, (_, state) {
      switch (state) {
        case AvatarEyesPositionState.BOTTOM_CENTER:
          _positionX?.value = 0;
          _positionY?.value = -200;
          break;
        case AvatarEyesPositionState.TOP_RIGHT:
          _positionX?.value = 200;
          _positionY?.value = 200;
          break;
        case AvatarEyesPositionState.TOP_LEFT:
          _positionX?.value = -200;
          _positionY?.value = 200;
          break;
        case AvatarEyesPositionState.CENTER_LEFT:
          _positionX?.value = -200;
          _positionY?.value = 0;
          break;
        case AvatarEyesPositionState.CENTER_RIGHT:
          _positionX?.value = 200;
          _positionY?.value = 0;
          break;
        case AvatarEyesPositionState.BOTTOM_RIGHT:
          _positionX?.value = 200;
          _positionY?.value = -200;
          break;
        case AvatarEyesPositionState.BOTTOM_LEFT:
          _positionX?.value = -200;
          _positionY?.value = -200;
          break;
        case AvatarEyesPositionState.TOP_CENTER:
          _positionX?.value = 0;
          _positionY?.value = 200;
          break;
        case AvatarEyesPositionState.CENTER:
          _positionX?.value = 0;
          _positionY?.value = 0;
          break;
      }
      setState(() {});
    });
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'state_machine');
    artboard.addController(controller!);
    _positionX = controller.findInput<double>('positionX') as SMINumber;
    _positionY = controller.findInput<double>('positionY') as SMINumber;
    _happy = controller.findInput<bool>('happy') as SMIBool;
    _sad = controller.findInput<bool>('sad') as SMIBool;
    _uncertain = controller.findInput<bool>('uncertain') as SMIBool;
  }
}
