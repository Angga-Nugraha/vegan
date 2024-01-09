import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vegan/data/utils/failure.dart';
import 'package:vegan/domain/usecase/Product/get_product.dart';
import 'package:vegan/presentation/bloc/product_bloc/product_bloc.dart';

import '../../dummy_data/object_dummy.dart';
import 'product_bloc_test.mocks.dart';

@GenerateMocks([GetAllProduct])
void main() {
  late ProductBloc productBloc;
  late MockGetAllProduct mockGetAllProduct;

  setUp(() {
    mockGetAllProduct = MockGetAllProduct();
    productBloc = ProductBloc(getAllProduct: mockGetAllProduct);
  });

  group('Product', () {
    blocTest<ProductBloc, ProductState>(
        'emits ProductLoaded when FetchAllProduct is added.',
        build: () {
          when(mockGetAllProduct.execute())
              .thenAnswer((_) async => Right([tProduct]));
          return productBloc;
        },
        act: (bloc) => bloc.add(const FetchAllProduct()),
        expect: () => <ProductState>[
              ProductLoading(),
              ProductLoaded(result: [tProduct]),
            ]);
    blocTest<ProductBloc, ProductState>(
        'emits ProductError when FetchAllProduct is added.',
        build: () {
          when(mockGetAllProduct.execute())
              .thenAnswer((_) async => const Left(ServerFailure('Error')));
          return productBloc;
        },
        act: (bloc) => bloc.add(const FetchAllProduct()),
        expect: () => <ProductState>[
              ProductLoading(),
              const ProductError(message: 'Error')
            ]);
  });
}
