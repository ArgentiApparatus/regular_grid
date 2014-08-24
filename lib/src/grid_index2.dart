part of regular_grid;

typedef int Convert(num);

int truncate(num a) => a.truncate();
int floor(num a) => a.floor();
int ceil(num a) => a.ceil();
int round(num a) => a.round();


class GridCoord2 implements Math.Point<int> {

  int x;
  int y;

  /// Construct a new grid coord with the specified values.
  GridCoord2(this.x, this.y);

  /// Zero grid coord.
  GridCoord2.zero(): x=0, y=0;

  /// Splat [value] into all values of [this].
  GridCoord2.all(int value): x=value, y=value;

  /// Copy of [other].
  GridCoord2.copy(Math.Point<int> other): x=other.x, y=other.y;

  /// Construct from [thing] that has type `num` `x` and `y` members converting values with function [convert].
  ///
  /// If either `x` or `y` of [thing] are not of type `num`, an exception will be thrown.
  GridCoord2.fromDynamic(dynamic thing, Convert convert): x=convert(thing.x), y=convert(thing.y);

  /// Set the values of [this].
  void setValues(int x, int y) {
    this.x = x;
    this.y = y;
  }

  /// Zero the grid coord.
  void setZero() {
    x = 0;
    y = 0;
  }

  /// Set values of [this] by copying from [other].
  void setFrom(Math.Point<int> other) {
    y = other.y;
    x = other.x;
  }

  /// Splat [value] into all values of [this].
  void splat(int value) {
    x = value;
    y = value;
  }

  /// Set values of [this] by copying from [point] converting values with function [convert].
  ///
  /// If either `x` or `y` of [thing] are not of type `num`, an exception will be thrown
  /// and the state of [this] will be indeterminate.
  void setFromDynamic(dynamic thing, Convert convert) {
    x = convert(thing.x);
    y = convert(thing.y);
  }

  /// Returns a printable string
  String toString() => '[${x},${y}]';

  /// Negate.
  GridCoord2 operator-() => new GridCoord2(-x, -y);

  /// Add two grid coords.
  GridCoord2 operator+(Math.Point<int> other) => new GridCoord2(x+other.x, y+other.y);

  /// Subtract two grid coords.
  GridCoord2 operator-(Math.Point<int> other) => new GridCoord2(x-other.x, y-other.y);

  /// Scale.
  GridCoord2 operator*(int scale) => new GridCoord2(x*scale, y*scale);

  /// Negate.
  void negate() {
    y = -y;
    x = -x;
  }

  /// Add [arg] to [this].
  void add(Math.Point<int> arg) {
    x += arg.x;
    y += arg.y;
  }

  /// Subtract [arg] from [this].
  void sub(Math.Point<int> arg) {
    x -= arg.x;
    y -= arg.y;
  }

  /// Multiply entries in [this] with corresponding entries in [arg].
  void multiplyElements(Math.Point<int> arg) {
    x *= arg.x;
    y *= arg.y;
  }

  /// Absolute value.
  void absolute() {
    y = y.abs();
    x = x.abs();
  }

  /// Scale [this].
  void scale(int arg) {
    y *= arg;
    x *= arg;
  }

  /// Return copy of [this] scaled by [scale]]
  GridCoord2 scaled(int scale) => new GridCoord2(x*scale, y*scale);

  /// Distance from [this] to [arg]
  double distanceTo(GridCoord2 arg) => (new GridCoord2.copy(this)..sub(arg)).length;

  /// Squared distance from [this] to [arg]
  int squaredDistanceTo(GridCoord2 arg) => (new GridCoord2.copy(this)..sub(arg)).squaredLength;

  /// Copy [this] into [arg], return [arg].
  GridCoord2 copyInto(GridCoord2 arg) {
    arg.y = y;
    arg.x = x;
    return arg;
  }

  /// Length.
  double get length => Math.sqrt((x*x)+(y*y));

  /// Magnitude - same as [length].
  double get magnitude => length;

  /// Length squared.
  int get squaredLength => (x*x)+(y*y);

  /// True if [x] and [y] are zero.
  bool get isZero => x==0 && y==0;

  /// True if either [x] or [y] are not zero.
  bool get isNotZero => x!=0 || y!=0;
}