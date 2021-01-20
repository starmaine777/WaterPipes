import 'dart:math';

import 'package:water_pipes/models/pipe_panel_model.dart';

/// Mapを作成
///
/// 1. 起点を決める
/// 2. 起点パネルを作る
/// 3. 上下左右で移動できる方向を取得、そのうち一方にパイプを通す
/// 4. 移動先のパネルを作成する
/// 5. 4.で上下左右につながっているパイプがある場合はその方向のパイプを通す
/// 6. 3.で移動できるパネルがなくなるまで繰り返す
/// 7. 起点をランダムで設定しなおし、2.に戻る
class CreateMapUseCase {
  CreateMapUseCase();

  List<List<PipePanelModel>> createMap(int rowSize, int columnSize) {
    List map = List(rowSize);
    var addedPanelCount = 0;

    map.forEach((element) {
      element.add(List<PipePanelModel>(columnSize));
    });

    final random = Random();

    var row = random.nextInt(map.length - 1);
    var column = random.nextInt(map[row].length - 1);
    while (addedPanelCount < rowSize * columnSize) {
      _addRoute(row, column, map, addedPanelCount, random);

      row = random.nextInt(map.length - 1);
      column = (map[row] as List<PipePanelModel>).first.columnIndex;
    }

    return map;
  }

  void _addRoute(int row, int column, List<List<PipePanelModel>> map,
      int addedPanelCount, Random random) {
    while (true) {
      var panel = _createPanel(row, column, map, random);
      map[row][column] = panel;
      addedPanelCount++;
      var candidateList = _createCandidateList(panel, row, column, map);
      if (candidateList.isEmpty) break;
      Direction direction =
          candidateList[random.nextInt(candidateList.length - 1)];
      switch (direction) {
        case Direction.LEFT:
          {
            panel.isLeftOpen = true;
            column--;
            break;
          }
        case Direction.TOP:
          {
            panel.isTopOpen = true;
            row--;
            break;
          }
        case Direction.RIGHT:
          {
            panel.isRightOpen = true;
            column++;
            break;
          }
        case Direction.BOTTOM:
          {
            panel.isBottomOpen = true;
            row++;
            break;
          }
      }
    }
  }

  PipePanelModel _createPanel(
      int row, int column, List<List<PipePanelModel>> map, Random random) {
    var panel = new PipePanelModel(rowIndex: row, columnIndex: column);
    panel.isLeftOpen = _needOpenLeftPipe(row, column, map);
    panel.isTopOpen = _needOpenTopPipe(row, column, map);
    panel.isRightOpen = _needOpenRightPipe(row, column, map);
    panel.isBottomOpen = _needOpenBottomPipe(row, column, map);
    return panel;
  }

  List<Direction> _createCandidateList(PipePanelModel panel, int row,
      int column, List<List<PipePanelModel>> map) {
    var openList = new List();
    if (!panel.isLeftOpen && _canOpenLeftPipe(row, column, map)) {
      openList.add(Direction.LEFT);
    }
    if (!panel.isTopOpen && _canOpenTopPipe(row, column, map)) {
      openList.add(Direction.TOP);
    }
    if (!panel.isRightOpen && _canOpenRightPipe(row, column, map)) {
      openList.add(Direction.RIGHT);
    }
    if (!panel.isBottomOpen && _canOpenBottomPipe(row, column, map)) {
      openList.add(Direction.BOTTOM);
    }
    return openList;
  }

  bool _canOpenLeftPipe(int row, int column, List<List<PipePanelModel>> map) {
    return column != 0 && map[row][column - 1] == null;
  }

  bool _canOpenTopPipe(int row, int column, List<List<PipePanelModel>> map) {
    return row != 0 && map[row - 1][column] == null;
  }

  bool _canOpenRightPipe(int row, int column, List<List<PipePanelModel>> map) {
    return column != map[row].length - 1 && map[row][column + 1] == null;
  }

  bool _canOpenBottomPipe(int row, int column, List<List<PipePanelModel>> map) {
    return row != map.length - 1 && map[row + 1][column] == null;
  }

  bool _needOpenLeftPipe(int row, int column, List<List<PipePanelModel>> map) {
    if (column == 0) {
      return false;
    } else
      return map[row][column - 1].isRightOpen;
  }

  bool _needOpenTopPipe(int row, int column, List<List<PipePanelModel>> map) {
    if (row == 0) {
      return false;
    } else
      return map[row - 1][column].isBottomOpen;
  }

  bool _needOpenRightPipe(int row, int column, List<List<PipePanelModel>> map) {
    if (column == map[row].length - 1) {
      return false;
    } else
      return map[row][column + 1].isLeftOpen;
  }

  bool _needOpenBottomPipe(
      int row, int column, List<List<PipePanelModel>> map) {
    if (row == map.length - 1) {
      return false;
    } else
      return map[row + 1][column].isTopOpen;
  }
}

enum Direction { LEFT, TOP, RIGHT, BOTTOM }
