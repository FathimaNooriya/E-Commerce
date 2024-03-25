part of 'cart_bloc.dart';

class CartEvent {}

class GetCartitems extends CartEvent {}

class AddToCartEvent extends CartEvent {
  ProductModel product;
  AddToCartEvent({required this.product});
}

class DeleteFromCartEvent extends CartEvent {
  CartModel cartItem;
  DeleteFromCartEvent({required this.cartItem});
}
