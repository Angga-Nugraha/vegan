import 'package:vegan/data/model/auth_model.dart';
import 'package:vegan/data/model/user_model.dart';
import 'package:vegan/domain/entities/auth.dart';
import 'package:vegan/domain/entities/user.dart';

final tUserModel = UserModel(
  id: "id",
  name: "name",
  email: "email",
  phone: "phone",
  password: "password",
  address: "address",
  role: "role",
  token: "token",
  image: "image",
  createdAt: DateTime.parse("2023-12-30 00:18:05.095080"),
  updatedAt: DateTime.parse("2023-12-30 00:18:05.095080"),
);

final tUser = User(
  id: "id",
  name: "name",
  email: "email",
  phone: "phone",
  password: "password",
  address: "address",
  role: "role",
  token: "token",
  image: "image",
  createdAt: DateTime.parse("2023-12-30 00:18:05.095080"),
  updatedAt: DateTime.parse("2023-12-30 00:18:05.095080"),
);

const tUserRegisterModel = UserModel(
  name: "name",
  email: "email",
  phone: "phone",
  password: "password",
  confPassword: "confPassword",
  address: "address",
);

const tUserRegister = User(
  name: "name",
  email: "email",
  phone: "phone",
  password: "password",
  confPassword: "confPassword",
  address: "address",
);

const tLoginModel = AuthModel(
    status: "success",
    id: "658ee9c8b16842b3c9bef815",
    accessToken:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1OGVlOWM4YjE2ODQyYjNjOWJlZjgxNSIsIm5hbWUiOiJhZG1pbiIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwiaWF0IjoxNzAzODY0NzgyLCJleHAiOjE3MDM5NTExODJ9.XxoCfuJ_ZlO-Pi_EPloAtsu-eaVehQFtHwLgkmXyIT0");

const tLogin = Auth(
  status: "success",
  id: "658ee9c8b16842b3c9bef815",
  accessToken:
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1OGVlOWM4YjE2ODQyYjNjOWJlZjgxNSIsIm5hbWUiOiJhZG1pbiIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwiaWF0IjoxNzAzODY0NzgyLCJleHAiOjE3MDM5NTExODJ9.XxoCfuJ_ZlO-Pi_EPloAtsu-eaVehQFtHwLgkmXyIT0",
);
