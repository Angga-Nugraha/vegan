part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

final class FetchAllProduct extends ProductEvent {
  const FetchAllProduct();

  @override
  List<Object> get props => [];
}
