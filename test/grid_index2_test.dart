part of regular_grid_test;

class Bomb {
  double x = 3.3;
  String y = 'y';
}

void grid_index2_tests() {

  GridCoord2 g, f;

  group('Constructors:', () {

    test('Values', () {
    g = new GridCoord2(-7, 9);
      expect(g.x, equals(-7));
      expect(g.y, equals(9));
    });
    test('Zero', () {
      g = new GridCoord2.zero();
      expect(g.x, isZero);
      expect(g.y, isZero);
    });
    test('All', () {
    g = new GridCoord2.all(5);
      expect(g.x, equals(5));
      expect(g.y, equals(5));
    });
    test('Copy', () {
    g = new GridCoord2.copy(new Point<int>(-7, 9));
      expect(g.x, equals(-7));
      expect(g.y, equals(9));
    });

    test('From dynamic with x and y', () {

      g = new GridCoord2.fromDynamic(new Point<double>(-7.7, 9.9), truncate);
      expect(g.x, equals(-7));
      expect(g.y, equals(9));

      g = new GridCoord2.fromDynamic(new Point<double>(-7.7, 9.9), floor);
      expect(g.x, equals(-8));
      expect(g.y, equals(9));

      g = new GridCoord2.fromDynamic(new Point<double>(-7.7, 9.9), ceil);
      expect(g.x, equals(-7));
      expect(g.y, equals(10));

      g = new GridCoord2.fromDynamic(new Point<double>(-7.7, 9.9), round);
      expect(g.x, equals(-8));
      expect(g.y, equals(10));
    });

    test('From dynamic with x and y, bad input', () {

      // TypeError in checked mode, NoSuchMethodError in unchecked
      expect(() { new GridCoord2.fromDynamic(new Bomb(), truncate); }, throws);
      expect(() { new GridCoord2.fromDynamic(new Bomb(), floor);    }, throws);
      expect(() { new GridCoord2.fromDynamic(new Bomb(), ceil);     }, throws);
      expect(() { new GridCoord2.fromDynamic(new Bomb(), round);    }, throws);
    });
  });

  group('Setters:', () {

    test('Values', () {
      g = new GridCoord2.zero()..setValues(-7, 9);
      expect(g.x, equals(-7));
      expect(g.y, equals(9));
    });
    test('Zero', () {
      g = new GridCoord2(-7, 9)..setZero();
      expect(g.x, isZero);
      expect(g.y, isZero);
    });
    test('From', () {
      g = new GridCoord2.zero()..setFrom(new Point<int>(-7, 9));
      expect(g.x, equals(-7));
      expect(g.y, equals(9));
    });

    test('From dynamic with x and y', () {

      g = new GridCoord2.zero()..setFromDynamic(new Point<double>(-7.7, 9.9), truncate);
      expect(g.x, equals(-7));
      expect(g.y, equals(9));

      g = new GridCoord2.zero()..setFromDynamic(new Point<double>(-7.7, 9.9), floor);
      expect(g.x, equals(-8));
      expect(g.y, equals(9));

      g = new GridCoord2.zero()..setFromDynamic(new Point<double>(-7.7, 9.9), ceil);
      expect(g.x, equals(-7));
      expect(g.y, equals(10));

      g = new GridCoord2.zero()..setFromDynamic(new Point<double>(-7.7, 9.9), round);
      expect(g.x, equals(-8));
      expect(g.y, equals(10));
    });

    test('From dynamic with x and y with bad input', () {

      // TypeError in checked mode, NoSuchMethodError in unchecked
      g = new GridCoord2.zero();
      expect(() { g.setFromDynamic(new Bomb(), truncate); }, throws);
      expect(() { g.setFromDynamic(new Bomb(), floor);    }, throws);
      expect(() { g.setFromDynamic(new Bomb(), ceil);     }, throws);
      expect(() { g.setFromDynamic(new Bomb(), round);    }, throws);
    });
  });

  group('Operators:', () {

    test('Negation', () {
      g = -(new GridCoord2(-7, 9));
      expect(g.x, equals(7));
      expect(g.y, equals(-9));
    });
    test('Addition', () {
      g = (new GridCoord2(-7, 9)) + (new GridCoord2(7, -9));
      expect(g.x, isZero);
      expect(g.y, isZero);
    });
    test('Subtraction', () {
      g = (new GridCoord2(-7, 9)) - (new GridCoord2(-7, 9));
      expect(g.x, isZero);
      expect(g.y, isZero);
    });
    test('Multiplication by int', () {
      g = new GridCoord2(-7, 9) * 3;
      expect(g.x, equals(-21));
      expect(g.y, equals(27));
    });
  });

  group('Operations on this:', () {

    test('Negate', () {
      g = new GridCoord2(-7, 9)..negate();
      expect(g.x, equals(7));
      expect(g.y, equals(-9));
    });
    test('Add', () {
      g = new GridCoord2(-7, 9)..add(new GridCoord2(7, -9));
      expect(g.x, isZero);
      expect(g.y, isZero);
    });
    test('Subtract', () {
      g = new GridCoord2(-7, 9)..sub(new GridCoord2(-7, 9));
      expect(g.x, isZero);
      expect(g.y, isZero);
    });
    test('Multiply elements', () {
      g = new GridCoord2(-7, 9)..multiplyElements(new GridCoord2(3, 3));
      expect(g.x, equals(-21));
      expect(g.y, equals(27));
    });
    test('Make absolute', () {
      g = new GridCoord2(-7, 9)..absolute();
      expect(g.x, equals(7));
      expect(g.y, equals(9));
    });
    test('Scale', () {
      g = new GridCoord2(-7, 9)..scale(3);
      expect(g.x, equals(-21));
      expect(g.y, equals(27));
    });
    test('Scaled copy', () {
      g = new GridCoord2(-7, 9);
      f = g.scaled(3);
      expect(identical(g, f), isFalse);
      expect(f.x, equals(-21));
      expect(f.y, equals(27));
    });
    test('Distance to', () {
      g = new GridCoord2(-7, 9);
      f = new GridCoord2(11, -13);
      expect(g.distanceTo(f), equals(sqrt(808)));
      expect(g.squaredDistanceTo(f), equals(808));
    });
    test('Copy into', () {
      g = new GridCoord2(-7, 9);
      f = new GridCoord2(11, -13);
      g.copyInto(f);
      expect(f.x, equals(-7));
      expect(f.y, equals(9));
    });
  });

  group('Properties:', () {

    test('Length', () {
      g = new GridCoord2(-7, 9);
      expect(g.length, equals(sqrt(130)));
      expect(g.magnitude, equals(sqrt(130)));
      expect(g.squaredLength, equals(130));
    });
    test('Is zero', () {
      g = new GridCoord2(0, 0);
      expect(g.isZero, isTrue);
      expect(g.isNotZero, isFalse);
      g = new GridCoord2(0, 9);
      expect(g.isZero, isFalse);
      expect(g.isNotZero, isTrue);
      g = new GridCoord2(-7, 0);
      expect(g.isZero, isFalse);
      expect(g.isNotZero, isTrue);
      g = new GridCoord2(-7, 9);
      expect(g.isZero, isFalse);
      expect(g.isNotZero, isTrue);
    });
  });
}