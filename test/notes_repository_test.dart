import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Normal data', () {
    final json = {"id": 1, "title": "Hello", "content": "World"};

    expect(json['id'], 1);
    expect(json['title'], "Hello");
  });

  test('Empty data', () {
    final json = [];

    expect(json.isEmpty, true);
  });

  test('Invalid data', () {
    final json = {"id": null, "title": null, "content": null};

    expect(json['id'], null);
  });
}