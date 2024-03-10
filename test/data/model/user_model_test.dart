import 'package:flutter_test/flutter_test.dart';
import 'package:vegan/data/model/user_model.dart';

import '../../dummy_data/object_dummy.dart';

void main() {
  test('should be a subclass of User to entity', () async {
    final result = tUserModel.toEntity();

    expect(result, tUser);
  });
  test('should be a subclass of User from entity', () async {
    final result = UserModel.fromEntity(tUserRegister);

    expect(result, tUserRegisterModel);
  });
  test('should be a subclass of User from entity to json', () async {
    final result = UserModel.fromEntity(tUserRegister).toJson();

    expect(result, tUserRegisterModel.toJson());
  });
  test('should be a subclass of Address from entity', () async {
    final result = AddressModel.fromEntity(address);

    expect(result, addressModel);
  });
  test('should be a subclass of Address from entity toJson', () async {
    final result = AddressModel.fromEntity(address).toJson();

    expect(result, addressModel.toJson());
  });
}
