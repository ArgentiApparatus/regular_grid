# Regular Grid

A small utility library for working with regular rectilinear grids.

## Features

* Simple but complete 2D regular grid index class with arithmetic operators, equality and compatibility with other point or vector like classes.

## Planned  Features

* 3D regular grid index class.
* 2D and 3D grid array classes. 

## Getting Started

`GridIndex2` implements `dart:math`'s `Point<int>`'s interface. All constructors, operators and methods that would normally be expected to take another `GridIndex2` actually take a `Point<int>`.

    import 'dart:math';
    ...
    Point<int> point = new Point<int>(-7, 9);
    GridIndex2 index = new GridIndex2.copy(point);
    index.copyFrom(point);
    index.add(point);

A `GridIndex2` may be constructed or copied from any object that has `x` and `y` properties of type `num`, and has four options for transforming those properties into `int` values: *truncate*, *floor*, *ceil* and *round* - in each case the appropriate conversion method is called on each property.

For instance, a `GridIndex2` may be constructed  and copied from a [vector_math](http://pub.dartlang.org/packages/vector_math) `Vector2`.

    import 'package:vector_math';
    ...
    Vector2 vector = new Vector2(-7.7, 9.9)
    GridIndex2 index = new GridIndex2.fromDynamic(vector, floor); // x=-8, y=9
    index.copyFromDynamic(vector, truncate); // x=-7, y=9

Component-wise equality is provided. Again `operator==` actually takes a `Point<int>`. Note that invoking `Point<int>`'s equality operator on a  `GridIndex2` also works as expected.

    GridIndex2 index1 = new GridIndex2(-7, 9);
    GridIndex2 index2 = new GridIndex2(-7, 9);
    GridIndex2 index2 = new GridIndex2(-14, 18);
    Point<int> point = new Point<int>(-7, 9);
    
    index1 == index2; // true
    index1 == index1; // true
    index1 == index3; // false
    index1 == point; // true
    point  == index1; // true
 
The `hashCode` property is implemented (using [Quiver's](http://pub.dartlang.org/packages/quiver) hash functions), so instances may be used as a `Map` index etc.

    var map = new Map<GridIndex2, ...>();
