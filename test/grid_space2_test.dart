part of regular_grid_test;

class MutablePoint {
  num x;
  num y;
  MutablePoint(this.x, this.y);
}

class PointMatcher extends Matcher {
  num x, y;
  PointMatcher(this.x, this.y);
  bool matches(MutablePoint t, Map matchState) => t.x==x && t.y==y;
  Description describe(Description description) => description.add('Point:<[$x,$y]>');
}

Matcher pointIs(num x, num y) => new PointMatcher(x, y);

void grid_space2_tests() {

  group('GridSpace2:', () {

    group('Constructors:', () {

      test('Rectangles', () {
        List<GridSpace2> rects
          = [new GridSpace2.rect(9.7, 7.5, offsetX:5.3, offsetY:3.1),
             new GridSpace2.fromDynamicRect(new Point<double>(9.7, 7.5), new Point<double>(5.3, 3.1)),
             new GridSpace2.fromDynamicPoints(new Point<double>(9.7+5.3, 7.5+3.1), new Point<double>(5.3, 3.1))];
        for(GridSpace2 s in rects) {
          expect(s.width, equals(9.7));
          expect(s.height, equals(7.5));
          expect(s.offsetX, equals(5.3));
          expect(s.offsetY, equals(3.1));
        }
      });

      test('Squares', () {
        List<GridSpace2> squares
          = [new GridSpace2.square(9.7, offsetX:5.3, offsetY:3.1),
             new GridSpace2.fromDynamicRect(new Point<double>(9.7, 9.7), new Point<double>(5.3, 3.1)),
             new GridSpace2.fromDynamicPoints(new Point<double>(9.7+5.3, 9.7+3.1), new Point<double>(5.3, 3.1))];
        for(GridSpace2 s in squares) {
          expect(s.width, equals(9.7));
          expect(s.height, equals(9.7));
          expect(s.offsetX, equals(5.3));
          expect(s.offsetY, equals(3.1));
        }
      });
    });

    group('Index to point:', () {

      test('Set point from', () {
        GridSpace2 s = new GridSpace2.rect(10, 10, offsetX:5, offsetY:5);
        GridIndex2 g = new GridIndex2(2, 2);
        MutablePoint t = s.setPointFrom(g, new MutablePoint(0, 0), dix:0.5, diy:0.5);
        expect(t, pointIs(30, 30));
      });
    });

    group('Point to index:', () {

      MutablePoint t = new MutablePoint(32, 32);
      GridSpace2 s = new GridSpace2.rect(10, 10, offsetX:5, offsetY:5);

      test('Set index from', () {
        GridIndex2 g = s.setIndexFrom(t, new GridIndex2.zero(), floor);
        expect(g, indexIs(2, 2));
      });

      test('Index from', () {
        GridIndex2 g = s.indexFrom(t, floor);
        expect(g, indexIs(2, 2));
      });

      test('Set index', () {
        GridIndex2 g = s.setIndex(32, 32, new GridIndex2.zero(), floor);
        expect(g, indexIs(2, 2));
      });

      test('Index', () {
        GridIndex2 g = s.index(32, 32, floor);
        expect(g, indexIs(2, 2));
      });
    });
  });
}