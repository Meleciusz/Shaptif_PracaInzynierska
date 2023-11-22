import 'package:body_parts_repository/body_parts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/trainings/home/widgets/all_trainings_widget/all_trainings_widget.dart';
import 'package:shaptifii/authorization/app/bloc/app_bloc.dart';
import '../bloc/category_widget_bloc.dart';
import 'item.dart';

class CategoriesSuccessWidget extends StatelessWidget {
  const CategoriesSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

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
                        context.read<AllTrainingsBloc>().add(GetTrainingsByCategory(
                            categoryName: categorySelected.part,
                            userID:  user.id
                        ));
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