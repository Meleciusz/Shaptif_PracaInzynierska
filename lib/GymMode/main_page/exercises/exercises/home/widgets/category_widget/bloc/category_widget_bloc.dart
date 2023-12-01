import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:body_parts_repository/body_parts_repository.dart';

part 'category_widget_event.dart';
part 'category_widget_state.dart';

/*
 * Main description:
This file describes every event that bloc can have and connects those events with the states and repositories
 */
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required this.firestoreService,
  }) : super(const CategoryState()){
    on<GetCategories>(_mapGetCategoriesEvent);
    on<SelectCategory>(_mapSelectCategoryEvent);
  }

  final FirestoreBodyPartsService firestoreService;

  void _mapGetCategoriesEvent(GetCategories event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    try{
      final categories = await firestoreService.getBodyParts();
      emit(state.copyWith(status: CategoryStatus.success, categories: categories));
    } catch(e){
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }

  void _mapSelectCategoryEvent(SelectCategory event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: CategoryStatus.selected, idSelected: event.idSelected));
  }
}
