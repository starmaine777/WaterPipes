import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_pipes/models/pipe_panel_model.dart';

/// 水道管ゲームを構成するパネル。
/// 正位置から上下左右につなげられるパイプの有無を所持
class PipePanel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<PipePanelModel>(
      builder: (context, model, child) {
        Color pipeColor =
            model.isFilled ? Colors.blue.shade500 : Colors.grey.shade500;
        return RotatedBox(
            quarterTurns: model.rotationIndex,
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
