import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  print(categorySelected.id);
                  // context.read<GetExercisesByCategoryBloc>().add(
                  //   GetExercisesByCategory(
                  //     idSelected : categorySelected.id,
                  //     categoryName: categorySelected.part ?? '',
                  //   )
                  // );
                  // context.read<CategoryWidgetBloc>().add(
                  //   CategorySelected(
                  //     idCategory: categorySelected.id
                  //   ),
                  // );
                },
              );
            },
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => SizedBox(width: 16),
            itemCount: categories.length,
        )
    );
  }
}