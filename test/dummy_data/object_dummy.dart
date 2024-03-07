import 'package:vegan/data/model/auth_model.dart';
import 'package:vegan/data/model/product_model.dart';
import 'package:vegan/data/model/user_model.dart';
import 'package:vegan/domain/entities/auth.dart';
import 'package:vegan/domain/entities/product.dart';
import 'package:vegan/domain/entities/user.dart';

final tUserModel = UserModel(
  id: "65a615e0ee0e998fa8b32068",
  name: "admin",
  email: "admin@gmail.com",
  phone: "081389042140",
  password: "\$2b\$10\$qKBGlQ6klNZFrikJ/w4psuoyIDz7PO4GUB36kFGmhzDQqNucHWXcm",
  address: const AddressModel(
    geoModel: GeoModel(lat: null, long: null),
    detailAddress: null,
    provinsi: null,
    kota: null,
    kecamatan: null,
    postalCode: null,
  ),
  image: null,
  role: "user",
  token:
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1YTYxNWUwZWUwZTk5OGZhOGIzMjA2OCIsIm5hbWUiOiJhZG1pbiIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwiaWF0IjoxNzA1MzkyMDc4LCJleHAiOjE3MDU0Nzg0Nzh9.95zULvaQD3y5FezxyDw6czml0qcWHaeApSDktd6iyhY",
  createdAt: DateTime.parse("2024-01-16T05:36:32.561Z"),
  updatedAt: DateTime.parse("2024-01-16T08:01:18.571Z"),
);

final tUser = User(
  id: "65a615e0ee0e998fa8b32068",
  name: "admin",
  email: "admin@gmail.com",
  phone: "081389042140",
  password: "\$2b\$10\$qKBGlQ6klNZFrikJ/w4psuoyIDz7PO4GUB36kFGmhzDQqNucHWXcm",
  address: const Address(
    geo: Geo(lat: null, long: null),
    detailAddress: null,
    provinsi: null,
    kota: null,
    kecamatan: null,
    postalCode: null,
  ),
  role: "user",
  token:
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1YTYxNWUwZWUwZTk5OGZhOGIzMjA2OCIsIm5hbWUiOiJhZG1pbiIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwiaWF0IjoxNzA1MzkyMDc4LCJleHAiOjE3MDU0Nzg0Nzh9.95zULvaQD3y5FezxyDw6czml0qcWHaeApSDktd6iyhY",
  image: null,
  createdAt: DateTime.parse("2024-01-16T05:36:32.561Z"),
  updatedAt: DateTime.parse("2024-01-16T08:01:18.571Z"),
);

const tUserRegisterModel = UserModel(
  name: "name",
  email: "email",
  phone: "phone",
  password: "password",
  confPassword: "confPassword",
);

const tUserRegister = User(
  name: "name",
  email: "email",
  phone: "phone",
  password: "password",
  confPassword: "confPassword",
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
  // userId: "658f9025e178b40826f858d4",
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
  // userId: "658f9025e178b40826f858d4",
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

final userModel = UserModel.fromEntity(tUserRegister);
