part of regular_grid2;

// TODO Document dynamic with no x,y values
// TODO document how conversion works

/// Represents a regular 2D grid on a plane, converts discrete grid indices to and from continuous points.
///
/// In the interests of efficiency, no constructors, setters or other methods check for `null` values passed as arguments.
/// If `null` values are passed, the results are undefined.
class GridSpace2 {

  final double _width;
  final double _height;
  final double _offsetX;
  final double _offsetY;

  /// Creates a new grid space with a square grid and an offset from the origin.
  GridSpace2.square(num width, {num offsetX:0.0, num offsetY:0.0}):
    _width = width.toDouble(),
    _height = width.toDouble(),
    _offsetX = offsetX.toDouble(),
    _offsetY = offsetY.toDouble();

  /// Creates a new grid space with a rectangular grid and an offset from the origin
  GridSpace2.rect(num width, num height, {num offsetX:0.0, num offsetY:0.0}):
    _width = width.toDouble(),
    _height = height.toDouble(),
    _offsetX = offsetX.toDouble(),
    _offsetY = offsetY.toDouble();

  /// Creates a new grid space with a rectangular grid, [rect] defines the grid rectangle, [offset] defines the offsret from the origin.
  GridSpace2.fromDynamicRect(dynamic rect, [dynamic offset=_ZERO]):
    _width = rect.x.toDouble(),
    _height = rect.y.toDouble(),
    _offsetX = offset.x.toDouble(),
    _offsetY = offset.y.toDouble();

  /// Creates a new grid space with a rectangular grid, [min] and [min] are the corners of the rectangle.
  GridSpace2.fromDynamicPoints(dynamic max, dynamic min):
    _width = max.x.toDouble() - min.x.toDouble(),
    _height = max.y.toDouble() - min.y.toDouble(),
    _offsetX = min.x.toDouble(),
    _offsetY = min.y.toDouble();

  double get width => _width;
  double get height => _height;
  double get offsetX => _offsetX;
  double get offsetY => _offsetY;

  /// Point x value corresponding to index x value [ix] in the grid space.
  double pointX(num ix) => (ix * _width) + _offsetX;

  /// Point y value corresponding to index y value [iy] in the grid space.
  double pointY(num iy) => (iy * _height) + _offsetY;

  /// Index x value corresponding to point x value [px] in the grid space.
  int indexX(num px, Convert convert) => convert((px-_offsetX)/_width);

  /// Index y value corresponding to point y value [py] in the grid space.
  int indexY(num py, Convert convert) => convert((py-_offsetY)/_height);

  /// Set `x` and `y` properties of object [point] to values corresponding to [index]  in the grid space and return [point].
  ///
  /// Optional parameters [dix] and [diy] allow adjustments to be added to [index] whis is useful for finding multiple points around a single index.
  /// Properties `x` and `y` of object [point] must be of type `num` or `dynamic` otherwise the results are undefined.
  dynamic setPointFrom(GridIndex2 index, dynamic point, {num dix:0, num diy:0}) {
    point.x = pointX(index.x + dix);
    point.y = pointY(index.y + diy);
    return point;
  }

  /// Return index of the grid rectangle corresponding to [point] in the grid space.
  ///
  /// Values of [point] are converting using function [convert].
  /// Object [point] must have properties `x` and `y` of type `num` otherwise the results are undefined.
  GridIndex2 indexFrom(dynamic point, Convert convert) {
    return new GridIndex2(indexX(point.x, convert), indexY(point.y, convert));
  }

  /// Return index of the grid rectangle corresponding to point ([px],[py]) in the grid space.
  ///
  /// Values of [point] are converting using function [convert].
  GridIndex2 index(num px, num py, Convert convert) {
    return new GridIndex2(indexX(px, convert), indexY(py, convert));
  }

  /// Set `x` and `y` properties of [index] to those corresponding [point] in the grid space.
  ///
  /// Values of [point] are converting using function [convert].
  /// Object [point] must have properties `x` and `y` of type `num` otherwise the results are undefined.
  GridIndex2 setIndexFrom(dynamic thing, GridIndex2 index, Convert convert) {
    index.x = indexX(thing.x, convert);
    index.y = indexY(thing.y, convert);
    return index;
  }

  /// Set `x` and `y` properties of [index] to those corresponding to point ([px],[py]) in the grid space.
  ///
  /// Values of [point] are converting using function [convert].
  GridIndex2 setIndex(num px, num py, GridIndex2 index, Convert convert) {
    index.x = indexX(px, convert);
    index.y = indexY(py, convert);
    return index;
  }
}

class _Zero {
  final double x = 0.0;
  final double y = 0.0;
  const _Zero();
}

const _ZERO = const _Zero();