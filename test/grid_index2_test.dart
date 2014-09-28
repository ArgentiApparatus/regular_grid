part of regular_grid_test;

class Bomb {
  double x = 3.3;
  String y = 'y';
}

class Grenade {
  double x = 3.3;
}

class GridIndex2Matcher extends Matcher {
  int x, y;
  GridIndex2Matcher(this.x, this.y);
  bool matches(GridIndex2 g, Map matchState) => g.x==x && g.y==y;
  Description describe(Description description) => description.add('GridIndex2:<[$x,$y]>');
}

Matcher indexIs(int x, int y) => new GridIndex2Matcher(x, y);

void grid_index2_tests() {

  GridIndex2 g, f;

  group('GridIndex2::', () {

    group('Constructors:', () {

      test('Values', () {
        g = new GridIndex2(-7, 9);
        expect(g, indexIs(-7, 9));
      });
      test('Zero', () {
        g = new GridIndex2.zero();
        expect(g, indexIs(0, 0));
      });
      test('All', () {
        g = new GridIndex2.all(5);
        expect(g, indexIs(5, 5));
      });
      test('Copy', () {
        g = new GridIndex2.copy(new Point<int>(-7, 9));
        expect(g, indexIs(-7, 9));
      });

      test('From dynamic with x and y', () {

        g = new GridIndex2.fromDynamic(new Point<double>(-7.7, 9.9), floor);
        expect(g, indexIs(-8, 9));

        g = new GridIndex2.fromDynamic(new Point<double>(-7.7, 9.9), ceil);
        expect(g, indexIs(-7, 10));

        g = new GridIndex2.fromDynamic(new Point<double>(-7.7, 9.9), round);
        expect(g, indexIs(-8, 10));
      });

      test('From dynamic with x and y, bad input', () {

        // TypeError in checked mode, NoSuchMethodError in unchecked
        expect(() { new GridIndex2.fromDynamic(new Bomb(),    floor); }, throws);
        expect(() { new GridIndex2.fromDynamic(new Bomb(),    ceil);  }, throws);
        expect(() { new GridIndex2.fromDynamic(new Bomb(),    round); }, throws);
        expect(() { new GridIndex2.fromDynamic(new Grenade(), floor); }, throws);
        expect(() { new GridIndex2.fromDynamic(new Grenade(), ceil);  }, throws);
        expect(() { new GridIndex2.fromDynamic(new Grenade(), round); }, throws);
      });
    });

    group('Setters:', () {

      test('Values', () {
        g = new GridIndex2.zero()..setValues(-7, 9);
        expect(g, indexIs(-7, 9));
      });
      test('Zero', () {
        g = new GridIndex2(-7, 9)..setZero();
        expect(g, indexIs(0, 0));
      });
      test('From', () {
        g = new GridIndex2.zero()..setFrom(new Point<int>(-7, 9));
        expect(g, indexIs(-7, 9));
      });

      test('From dynamic with x and y', () {

        g = new GridIndex2.zero()..setFromDynamic(new Point<double>(-7.7, 9.9), floor);
        expect(g, indexIs(-8, 9));

        g = new GridIndex2.zero()..setFromDynamic(new Point<double>(-7.7, 9.9), ceil);
        expect(g, indexIs(-7, 10));

        g = new GridIndex2.zero()..setFromDynamic(new Point<double>(-7.7, 9.9), round);
        expect(g, indexIs(-8, 10));
      });

      test('From dynamic with x and y with bad input', () {

        // TypeError in checked mode, NoSuchMethodError in unchecked
        g = new GridIndex2.zero();
        expect(() { g.setFromDynamic(new Bomb(),    floor); }, throws);
        expect(() { g.setFromDynamic(new Bomb(),    ceil);  }, throws);
        expect(() { g.setFromDynamic(new Bomb(),    round); }, throws);
        expect(() { g.setFromDynamic(new Grenade(), floor); }, throws);
        expect(() { g.setFromDynamic(new Grenade(), ceil);  }, throws);
        expect(() { g.setFromDynamic(new Grenade(), round); }, throws);
      });
    });

    group('Operators:', () {

      test('Negation', () {
        g = -(new GridIndex2(-7, 9));
        expect(g, indexIs(7, -9));
      });
      test('Addition', () {
        g = (new GridIndex2(-7, 9)) + (new GridIndex2(7, -9));
        expect(g, indexIs(0, 0));
      });
      test('Subtraction', () {
        g = (new GridIndex2(-7, 9)) - (new GridIndex2(-7, 9));
        expect(g, indexIs(0, 0));
      });
      test('Multiplication by int', () {
        g = new GridIndex2(-7, 9) * 3;
        expect(g, indexIs(-21, 27));
      });
    });

    group('Operations on this:', () {

      test('Negate', () {
        g = new GridIndex2(-7, 9)..negate();
        expect(g, indexIs(7, -9));
      });
      test('Add', () {
        g = new GridIndex2(-7, 9)..add(new GridIndex2(7, -9));
        expect(g, indexIs(0, 0));
      });
      test('Subtract', () {
        g = new GridIndex2(-7, 9)..sub(new GridIndex2(-7, 9));
        expect(g, indexIs(0, 0));
      });
      test('Multiply elements', () {
        g = new GridIndex2(-7, 9)..multiplyElements(new GridIndex2(3, 3));
        expect(g, indexIs(-21, 27));
      });
      test('Make absolute', () {
        g = new GridIndex2(-7, 9)..absolute();
        expect(g, indexIs(7, 9));
      });
      test('Scale', () {
        g = new GridIndex2(-7, 9)..scale(3);
        expect(g, indexIs(-21, 27));
      });
      test('Scaled copy', () {
        g = new GridIndex2(-7, 9);
        f = g.scaled(3);
        expect(f, isNot(same(g)));
        expect(f, indexIs(-21, 27));
      });
      test('Distance to', () {
        g = new GridIndex2(-7, 9);
        f = new GridIndex2(11, -13);
        expect(g.distanceTo(f), equals(sqrt(808)));
        expect(g.squaredDistanceTo(f), equals(808));
      });
      test('Copy into', () {
        g = new GridIndex2(-7, 9);
        f = new GridIndex2(11, -13);
        g.copyInto(f);
        expect(g, indexIs(-7, 9));
      });
    });

    group('Properties:', () {

      test('Length', () {
        g = new GridIndex2(-7, 9);
        expect(g.length, equals(sqrt(130)));
        expect(g.magnitude, equals(sqrt(130)));
        expect(g.squaredLength, equals(130));
      });
      test('Is zero', () {
        g = new GridIndex2(0, 0);
        expect(g.isZero, isTrue);
        expect(g.isNotZero, isFalse);
        g = new GridIndex2(0, 9);
        expect(g.isZero, isFalse);
        expect(g.isNotZero, isTrue);
        g = new GridIndex2(-7, 0);
        expect(g.isZero, isFalse);
        expect(g.isNotZero, isTrue);
        g = new GridIndex2(-7, 9);
        expect(g.isZero, isFalse);
        expect(g.isNotZero, isTrue);
      });
    });

    group('Equals and hashCode:', () {

      test('Equal', () {
        g = new GridIndex2(-7, 9);
        f = new GridIndex2(-7, 9);
        expect(g, equals(g));
        expect(g, equals(f));
        expect(g.hashCode, equals(f.hashCode));
      });
      test('Not equal', () {
        g = new GridIndex2(-7, 9);
        f = new GridIndex2(16, 32);
        expect(g, isNot(equals(f)));
        expect(g.hashCode, isNot(equals(f.hashCode)));
      });
    });
  });
}