part of regular_grid2;

typedef int Convert(num);

int floor(num a) => a.floor();
int ceil(num a) => a.ceil();
int round(num a) => a.round();

/// 2D regular grid index.
///
/// In the interests of efficiency, no constructors, setters or methods check for `null` values passed as arguments.
/// If `null` values are passed, the results are undefined.
class GridIndex2 implements Math.Point<int> {

  int x;
  int y;

  /// Construct a new grid coord with the specified values.
  GridIndex2(this.x, this.y);

  /// Zero grid coord.
  GridIndex2.zero(): x=0, y=0;

  /// Splat [value] into all values of [this].
  GridIndex2.all(int value): x=value, y=value;

  /// Copy of [other].
  GridIndex2.copy(Math.Point<int> other): x=other.x, y=other.y;

  /// Construct from object [thing] that has properties `x` and `y` of type `num`, converting their values with function [convert].
  ///
  /// If either property `x` or `y` of object [thing] is not of type `num`, the results are undefined.
  GridIndex2.fromDynamic(dynamic thing, Convert convert): x=convert(thing.x), y=convert(thing.y);

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
  GridIndex2 operator-() => new GridIndex2(-x, -y);

  /// Add two grid coords.
  GridIndex2 operator+(Math.Point<int> other) => new GridIndex2(x+other.x, y+other.y);

  /// Subtract two grid coords.
  GridIndex2 operator-(Math.Point<int> other) => new GridIndex2(x-other.x, y-other.y);

  /// Scale.
  GridIndex2 operator*(int scale) => new GridIndex2(x*scale, y*scale);

  /// Equality.
  bool operator==(Math.Point<int> other) => identical(this, other) || (x==other.x && y==other.y);

  /// Negate [this].
  void negate() {
    y = -y;
    x = -x;
  }

  /// Add [other] to [this].
  void add(Math.Point<int> other) {
    x += other.x;
    y += other.y;
  }

  /// Subtract [other] from [this].
  void sub(Math.Point<int> other) {
    x -= other.x;
    y -= other.y;
  }

  /// Multiply entries in [this] with corresponding entries in [other].
  void multiplyElements(Math.Point<int> other) {
    x *= other.x;
    y *= other.y;
  }

  /// Absolute value.
  void absolute() {
    y = y.abs();
    x = x.abs();
  }

  /// Scale [this].
  void scale(int scale) {
    y *= scale;
    x *= scale;
  }

  /// Return copy of [this] scaled by [scale]
  GridIndex2 scaled(int scale) => new GridIndex2(x*scale, y*scale);

  /// Distance from [this] to [other]
  double distanceTo(Math.Point<int> other) => (new GridIndex2.copy(this)..sub(other)).length;

  /// Squared distance from [this] to [other]
  int squaredDistanceTo(Math.Point<int> other) => (new GridIndex2.copy(this)..sub(other)).squaredLength;

  /// Copy [this] into [other], return [other].
  GridIndex2 copyInto(GridIndex2 other) {
    other.y = y;
    other.x = x;
    return other;
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

  int get hashCode => hash2(x, y);
}