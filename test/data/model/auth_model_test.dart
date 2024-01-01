import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/object_dummy.dart';

void main() {
  test('should be Auth subclass to entitiy', () async {
    final result = tLoginModel.toEntity();

    expect(result, tLogin);
  });
}
