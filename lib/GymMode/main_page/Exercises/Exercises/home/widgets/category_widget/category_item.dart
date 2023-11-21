import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets.dart';

typedef CategoryCLicked = Function(BodyParts categorySelected);

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category, required this.categoryClicked});

  final CategoryCLicked categoryClicked;
  final BodyParts category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => categoryClicked(category),
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
                  color: state ? const Color.fromARGB(255, 163, 187, 173) : const Color.fromARGB(
                      255, 236, 128, 128),
                ),
                child: state ? const Icon(Icons.zoom_out_map_outlined) : const Icon(Icons.zoom_in_map_outlined),
              ),
              const SizedBox(height: 4.0),
              Container(
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