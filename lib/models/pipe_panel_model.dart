// PipePanelクラスで利用するmodel
import 'package:flutter/material.dart';

// PipePanelクラスで使われるModelクラス
class PipePanelModel extends ChangeNotifier {
  PipePanelModel(
      {@required this.isLeftOpen,
      @required this.isTopOpen,
      @required this.isBottomOpen,
      @required this.isRightOpen});

  bool isLeftOpen = false;
  bool isTopOpen = false;
  bool isRightOpen = false;
  bool isBottomOpen = false;
  bool isFilled = false;
  int rotationIndex = 0;

  void changeFill() {
    isFilled = !isFilled;
    notifyListeners();
  }

  void changeRotation() {
    var nextIndex = rotationIndex + 1;
    if (nextIndex == Rotation.values.length) {
      nextIndex = 0;
    }
    rotationIndex = nextIndex;
    notifyListeners();
  }
}

enum Rotation { NONE, ROTATION_90, ROTATION_180, ROTATION_270 }

extension RotationHelper on Rotation {
  int get quarterTurns {
    switch (this) {
      case Rotation.NONE:
        return 0;
      case Rotation.ROTATION_90:
        return 1;
      case Rotation.ROTATION_180:
        return 2;
      case Rotation.ROTATION_270:
        return 3;
    }
    return 0;
  }
}
