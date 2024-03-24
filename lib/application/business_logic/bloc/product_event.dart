part of 'product_bloc.dart';

class ProductEvent {}

class GetAllProductsEvent extends ProductEvent {}

class GetCartitems extends ProductEvent {}

class AddToCartEvent extends ProductEvent {
  StoreModel product;
  AddToCartEvent({required this.product});
}

class DeleteFromCartEvent extends ProductEvent {
  CartModel cartItem;
  DeleteFromCartEvent({required this.cartItem});
}

class AddToFavorateEvent extends ProductEvent {
  StoreModel product;
  AddToFavorateEvent({required this.product});
}