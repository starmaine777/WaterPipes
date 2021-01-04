import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 水道管ゲームを構成するパネル。
/// 正位置から上下左右につなげられるパイプの有無を所持
class PipePanel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<PipePanelModel>(
      builder: (context, model, child) {
        Color pipeColor =
            model._isFilled ? Colors.blue.shade500 : Colors.grey.shade500;
        return RotatedBox(
            quarterTurns: model._rotationIndex,
            child: Container(
              width: 50,
              height: 50,
              color: Colors.grey.shade300,
              child: Stack(
                children: [
                  Opacity(
                    opacity: model.isTopOpen ? 1.0 : 0.0,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 10,
                    height: 30,
                    color: pipeColor,
                  ),
                ),
              ),
              Opacity(
                opacity: model.isLeftOpen ? 1.0 : 0.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 30,
                    height: 10,
                    color: pipeColor,
                  ),
                ),
              ),
              Opacity(
                opacity: model.isRightOpen ? 1.0 : 0.0,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 30,
                    height: 10,
                    color: pipeColor,
                  ),
                ),
              ),
              Opacity(
                opacity: model.isBottomOpen ? 1.0 : 0.0,
                child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 10,
                        height: 30,
                        color: pipeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class PipePanelModel extends ChangeNotifier {
  bool isLeftOpen = false;
  bool isTopOpen = false;
  bool isRightOpen = false;
  bool isBottomOpen = false;

  PipePanelModel({@required this.isLeftOpen,
    @required this.isTopOpen,
    @required this.isBottomOpen,
    @required this.isRightOpen});

  bool _isFilled = false;

  int _rotationIndex = 0;

  void changeFill() {
    _isFilled = !_isFilled;
    notifyListeners();
  }

  void changeRotation() {
    var nextIndex = _rotationIndex + 1;
    if (nextIndex == Rotation.values.length) {
      nextIndex = 0;
    }
    _rotationIndex = nextIndex;
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
