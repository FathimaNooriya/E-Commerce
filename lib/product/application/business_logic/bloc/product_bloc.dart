import 'package:bloc/bloc.dart';
import 'package:e_commerce/product/data/model/product_model.dart';

import '../../../domain/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  List<ProductModel> productList = [];

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<GetAllProductsEvent>(fetchAllProducts);

    on<AddToFavorateEvent>(addToFavorateEvent);
  }

  Future<void> fetchAllProducts(
      GetAllProductsEvent event, Emitter<ProductState> emit) async {
    emit(Loading());
    productList = await productRepository.fetchData(productList: productList);
    if (productList.isNotEmpty) {
      emit(FetchProductsSuccess());
    } else {
      emit(FetchProductsFailed());
    }
  }

  Future<void> addToFavorateEvent(
      AddToFavorateEvent event, Emitter<ProductState> emit) async {
    //  emit(AddToCartLoading());
    String result =
        await productRepository.addToFavorate(product: event.product);
    if (result == "Success") {
      emit(FavorateSucces());
    } else {
      emit(FavorateFailed());
    }
  }
}
