import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/exercises/exercises/home/widgets/exercises_by_category/bloc/exercises_by_category_bloc.dart';
import 'category_widget.dart';

/*
 * Main description:
 This class describes category widget
 */
class CategoriesSuccessWidget extends StatelessWidget {
  const CategoriesSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .15,
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return CategoryItem(
                      key: ValueKey('${state.categories[index].part}$index'),
                      category: state.categories[index],
                      categoryClicked: (BodyParts categorySelected){
                        context.read<ExercisesByCategoryBloc>().add(
                          GetExercisesByCategory(
                            idSelected: categorySelected.id,
                            categoryName: categorySelected.part,
                          )
                        );
                        context.read<CategoryBloc>().add(
                          SelectCategory(
                              idSelected: categorySelected.id,
                          )
                        );
                      }
                  );
                },
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => const SizedBox(
                  width: 16.0,
                ),
                itemCount: state.categories.length
            ),
          );
        }
    );
  }
}