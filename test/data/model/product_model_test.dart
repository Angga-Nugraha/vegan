import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/object_dummy.dart';

void main() {
  test('should be product model to sublass product entity', () async {
    final result = tProductModel.toEntity();

    expect(result, tProduct);
  });
}
