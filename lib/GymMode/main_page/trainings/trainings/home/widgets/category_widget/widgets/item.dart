import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_widget_bloc.dart';

//function that return selected category from body parts
typedef CategoryCLicked = Function(BodyParts categorySelected);


/*
 * Main description:
class that describes item of category widget
 */
class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category, required this.categoryClicked});

  //function that return selected category from body parts
  final CategoryCLicked categoryClicked;

  //category that will be displayed
  final BodyParts category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      //change state of selected category
        onTap: () => categoryClicked(category),

        //display category widget
        child: BlocSelector<CategoryBloc, CategoryState, bool>(
          selector: (state) => (state.status.isSelected && state.idSelected == category.id) ? true : false,
          builder: (context, state){
            return Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutCirc,
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  alignment: Alignment.center,
                  height: state ? 70.0 : 60.0,
                  width: state ? 70.0 : 60.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: state ? const Color.fromARGB(255, 163, 187, 173) : const Color.fromARGB(255, 130, 189, 149),
                  ),
                  child: state ? const Icon(Icons.bubble_chart_rounded) : const Icon(Icons.apps),
                ),
                const SizedBox(height: 4.0),
                SizedBox(
                    width: 60,
                    child: Text(
                      category.part ?? "",
                      style: const TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                )
              ],
            );
          },
        )
    );
  }
}