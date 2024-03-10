import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegan/domain/entities/product.dart';
import 'package:vegan/domain/usecase/Product/get_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProduct getAllProduct;

  ProductBloc({required this.getAllProduct}) : super(ProductInitial()) {
    on<FetchAllProduct>((event, emit) async {
      emit(ProductLoading());
      final result = await getAllProduct.execute();
      await Future.delayed(const Duration(seconds: 3));

      result.fold(
        (failure) => emit(ProductError(message: failure.message)),
        (data) => emit(ProductLoaded(result: data)),
      );
    });
  }
}
