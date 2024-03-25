import 'package:bloc/bloc.dart';
import '../../../data/model/my_cart_model.dart';
import '../../../../product/data/model/product_model.dart';
import '../../../domain/entities/cart_model.dart';
import '../../../domain/repository/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;
  List<MyCartModel> cartItems = [];
  List<CartModel> cartProducts = [];

  CartBloc(this.cartRepository) : super(CartInitial()) {
    on<GetCartitems>(getCartItems);
    on<AddToCartEvent>(addToCartEvent);
    on<DeleteFromCartEvent>(deleteFromCartEvent);
  }

  Future<void> getCartItems(GetCartitems event, Emitter<CartState> emit) async {
    emit(CartLoading());
    cartProducts = await cartRepository.fetchCartItems(
        cartItems: cartItems, cartProducts: cartProducts);
    if (cartProducts.isNotEmpty) {
      emit(FetchCartSuccess());
    } else {
      emit(FetchCartFailed());
    }
  }

  Future<void> addToCartEvent(
      AddToCartEvent event, Emitter<CartState> emit) async {
    emit(AddToCartLoading());
    String result = await cartRepository.addToCart(product: event.product);
    if (result == "Success") {
      emit(AddingSucces());
    } else {
      emit(AddingFailed());
    }
  }

  Future<void> deleteFromCartEvent(
      DeleteFromCartEvent event, Emitter<CartState> emit) async {
    emit(DeleteCartLoading());
    String result =
        await cartRepository.deleteFromCart(cartProduct: event.cartItem);
    if (result == "Success") {
      emit(DeleteSucces());
    } else {
      emit(DeleteFailed());
    }
  }
}
