import 'package:bloc/bloc.dart';
import 'package:e_commerce/domain/model/cart_model.dart';
import 'package:e_commerce/domain/model/my_cart_model.dart';
import 'package:e_commerce/domain/model/store_model.dart';
import 'package:flutter/material.dart';

import '../../../domain/functions/add_favorate.dart';
import '../../../domain/functions/add_to_cart.dart';
import '../../../domain/functions/delete_from_cart.dart';
import '../../../domain/functions/get_cart_items.dart';
import '../../../domain/functions/get_data.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<StoreModel> productList = [];
  List<MyCartModel> cartItems = [];
  List<CartModel> cartProducts = [];

  ProductBloc() : super(ProductInitial()) {
    on<GetAllProductsEvent>(fetchAllProducts);
    on<GetCartitems>(getCartItems);
    on<AddToCartEvent>(addToCartEvent);
    on<DeleteFromCartEvent>(deleteFromCartEvent);
    on<AddToFavorateEvent>(addToFavorateEvent);
  }

  Future<void> fetchAllProducts(
      GetAllProductsEvent event, Emitter<ProductState> emit) async {
    emit(Loading());
    productList = await fetchData(productList: productList);
    if (productList.isNotEmpty) {
      emit(FetchProductsSuccess());
    } else {
      emit(FetchProductsFailed());
    }
  }

  Future<void> getCartItems(
      GetCartitems event, Emitter<ProductState> emit) async {
    emit(Loading());
    cartProducts =
        await fetchCartItems(cartItems: cartItems, cartProducts: cartProducts);
    if (cartProducts.isNotEmpty) {
      emit(FetchCartSuccess());
    } else {
      emit(FetchCartFailed());
    }
  }

  Future<void> addToCartEvent(
      AddToCartEvent event, Emitter<ProductState> emit) async {
    emit(AddToCartLoading());
    String result = await addToCart(product: event.product);
    if (result == "Success") {
      emit(AddingSucces());
    } else {
      emit(AddingFailed());
    }
  }

  Future<void> deleteFromCartEvent(
      DeleteFromCartEvent event, Emitter<ProductState> emit) async {
    emit(DeleteCartLoading());
    String result = await deleteFromCart(cartProduct: event.cartItem);
    if (result == "Success") {
      emit(DeleteSucces());
    } else {
      SnackBar(content: Text(result));
      emit(DeleteFailed());
    }
  }

  Future<void> addToFavorateEvent(
      AddToFavorateEvent event, Emitter<ProductState> emit) async {
    //  emit(AddToCartLoading());
    String result = await addToFavorate(product: event.product);
    if (result == "Success") {
      emit(FavorateSucces());
    } else {
      emit(FavorateFailed());
    }
  }
}
