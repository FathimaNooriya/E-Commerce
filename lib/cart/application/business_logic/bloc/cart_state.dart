part of 'cart_bloc.dart';

class CartState {}

final class CartInitial extends CartState {}

class CartLoading extends CartState {}

class FetchCartSuccess extends CartState {}

class FetchCartFailed extends CartState {}

class AddingSucces extends CartState {}

class AddingFailed extends CartState {}

class AddToCartLoading extends CartState {}

class DeleteCartLoading extends CartState {}

class DeleteSucces extends CartState {}

class DeleteFailed extends CartState {}
