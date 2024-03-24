part of 'product_bloc.dart';

class ProductState {}

final class ProductInitial extends ProductState {}

class Loading extends ProductState {}

class FetchProductsSuccess extends ProductState {}

class FetchProductsFailed extends ProductState {}

class FetchCartSuccess extends ProductState {}

class FetchCartFailed extends ProductState {}

class AddingSucces extends ProductState {}

class AddingFailed extends ProductState {}

class AddToCartLoading extends ProductState {}

class DeleteCartLoading extends ProductState {}

class DeleteSucces extends ProductState {}

class DeleteFailed extends ProductState {}

class FavorateSucces extends ProductState {}

class FavorateFailed extends ProductState {}
