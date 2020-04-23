/// Shape is a simple structure for the explicit
/// representation of the row and column dimensions
/// of an instance of [Matrix]
class Shape {
  int rows;
  int cols;

  Shape(this.rows, this.cols);

  @override
  String toString() {
    var out = "Shape(rows: $rows, cols: $cols)";
    return out;
  }

  @override
  bool operator ==(Object other) {
    return (other is Shape) && (other.rows == rows) && (other.cols == cols);
  }
}

/// The Matrix class
/// A matrix represents a 2D array of doubles
class Matrix {
  List<List<double>> _values;

  Matrix(List<List<double>> values, {bool isStrict = true}) {
    if (isStrict) {
      int colLen = values[0].length;
      values.asMap().forEach((ix, row) {
        if (row.length != colLen) {
          throw ArgumentError.value('${row.length}', 'row length',
              'length of row at index $ix : $row must be equal to $colLen');
        }
      });
    }

    _values = values;
  }

  /// Returns the [Shape] of a [Matrix]
  Shape shape() {
    return Shape(_values.length, _values[0].length);
  }

  /// Returns internal matrix values as List<List<double>>
  List<List<double>> data() {
    return this._values;
  }

  /// Creates a [Matrix] of the given [shape] and initializes each value to the specified [value]
  static Matrix filled(double value, Shape shape) {
    var values = List.generate(
        shape.rows, (_) => List<double>.generate(shape.cols, (_) => value));

    return Matrix(values);
  }

  /// Creates a [Matrix] of the given [shape] and initializes each value 0.0
  static Matrix zeros(Shape shape) {
    var values = List.generate(
        shape.rows, (_) => List<double>.generate(shape.cols, (_) => 0.0));

    return Matrix(values);
  }

  /// Creates a [Matrix] of the given [shape] and initializes each value 1.0
  static Matrix ones(Shape shape) {
    var values = List.generate(
        shape.rows, (_) => List<double>.generate(shape.cols, (_) => 1.0));

    return Matrix(values);
  }

  @override
  String toString() {
    var out = 'Matrix(shape: ${this.shape()}, values: ${this.data()})';
    return out;
  }

  @override
  bool operator ==(Object other) {
    return (other is Matrix) && (other.data() == this.data());
  }

  @override
  Matrix operator +(Matrix other) {
    if (other.shape() != this.shape()) {
      throw ArgumentError.value('${other.shape()}', 'other shape',
          'shape of other matrix does not match ${this.shape()}');
    }

    List<List<double>> result = [];

    this._values.asMap().forEach((ix, row) {
      List<double> resultRow = [];
      var otherRow = other._values[ix];
      row.asMap().forEach((i, val) {
        resultRow.add(val + otherRow[i]);
      });

      result.add(resultRow);
    });

    return Matrix(result.cast<List<double>>());
  }
}
