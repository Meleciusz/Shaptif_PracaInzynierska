import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/exercises_by_category/bloc/exercises_by_category_bloc.dart';
import 'category_widget.dart';

class CategoriesSuccessWidget extends StatelessWidget {
  const CategoriesSuccessWidget({super.key, required this.categories});
  final List<BodyParts> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * .15,
        child: ListView.separated(
            itemBuilder: (context, index) {
              return CategoryItem(
                category: categories[index],
                categoryClicked: (BodyParts categorySelected){
                  context.read<ExercisesByCategoryBloc>().add(
                    GetExercisesByCategory(
                      categorySelected.part ?? '',
                    )
                  );
                },
              );
            },
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemCount: categories.length,
        )
    );
  }
}