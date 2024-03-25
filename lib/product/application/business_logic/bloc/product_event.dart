part of 'product_bloc.dart';

class ProductEvent {}

class GetAllProductsEvent extends ProductEvent {}

class AddToFavorateEvent extends ProductEvent {
  ProductModel product;
  AddToFavorateEvent({required this.product});
}