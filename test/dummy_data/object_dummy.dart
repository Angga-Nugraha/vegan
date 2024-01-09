import 'package:vegan/data/model/auth_model.dart';
import 'package:vegan/data/model/product_model.dart';
import 'package:vegan/data/model/user_model.dart';
import 'package:vegan/domain/entities/auth.dart';
import 'package:vegan/domain/entities/product.dart';
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

final tProductModel = ProductModel(
  id: "6598078eb523ef0e3393abce",
  userId: "658f9025e178b40826f858d4",
  title: "kol",
  description:
      "lorem ipsum dolor sit amet consectetur adipisicing elit. aperiam, esse maxime voluptatem deleniti quasi maiores suscipit ducimus nobis facilis assumenda quam aliquam temporibus molestias dolore?",
  price: 25000,
  ratting: 4.5,
  stock: 999,
  weight: 5,
  category: const ["sayur"],
  imageUrl: const [],
  createdAt: DateTime.parse('2024-01-05T13:43:44.683Z'),
  updatedAt: DateTime.parse('2024-01-05T13:43:44.683Z'),
);

final tProduct = Product(
  id: "6598078eb523ef0e3393abce",
  userId: "658f9025e178b40826f858d4",
  title: "kol",
  description:
      "lorem ipsum dolor sit amet consectetur adipisicing elit. aperiam, esse maxime voluptatem deleniti quasi maiores suscipit ducimus nobis facilis assumenda quam aliquam temporibus molestias dolore?",
  price: 25000,
  ratting: 4.5,
  stock: 999,
  weight: 5,
  category: const ["sayur"],
  imageUrl: const [],
  createdAt: DateTime.parse('2024-01-05T13:43:44.683Z'),
  updatedAt: DateTime.parse('2024-01-05T13:43:44.683Z'),
);
