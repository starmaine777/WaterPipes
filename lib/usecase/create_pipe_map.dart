import 'dart:math';

import 'package:water_pipes/models/pipe_panel_model.dart';

// Mapを作成
class CreateMapUseCase {
  CreateMapUseCase();

  List<List<PipePanelModel>> createMap(int rowSize, int columnSize) {
    List resultMap = List(rowSize);
    resultMap.forEach((element) {
      element.add(List<PipePanelModel>(columnSize));
    });

    return resultMap;
  }

  PipePanelModel createPipePanel(
      int row, int column, List<List<PipePanelModel>> map, Random random) {
    bool isTopOpen = false;
    if (row != 0) {
      var topPanel = map[row - 1][column];
      if (topPanel != null && topPanel.isBottomOpen) {
        isTopOpen = true;
      } else {
        isTopOpen = random.nextBool();
      }
    }


  }
}
