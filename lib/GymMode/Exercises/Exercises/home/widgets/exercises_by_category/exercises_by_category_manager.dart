import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/all_exercises_widget/bloc/all_exercises_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/home/widgets/exercises_by_category/bloc/exercises_by_category_bloc.dart';
import '../category_widget/bloc/category_widget_bloc.dart';
import 'exercises_by_category_success.dart';

class ExercisesByCategory extends StatefulWidget {
  const ExercisesByCategory({super.key});

  @override
  State<ExercisesByCategory> createState() => _ExercisesByCategoryState();
}

class _ExercisesByCategoryState extends State<ExercisesByCategory> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ExercisesByCategoryBloc exercisesByCategoryBloc = BlocProvider.of<ExercisesByCategoryBloc>(context);
    final CategoryWidgetBloc categoryWidgetBloc = BlocProvider.of<CategoryWidgetBloc>(context);
    final AllExercisesBloc allExercisesBloc = BlocProvider.of<AllExercisesBloc>(context);

    return BlocBuilder<ExercisesByCategoryBloc, ExercisesByCategoryState>(
      builder: (context, state) {
        if(state is ExercisesByCategoryLoading){
          return const Center(child: CircularProgressIndicator());
        }
        else if(state is ExercisesByCategoryLoaded){
          return CategoriesSuccessWidget(exercises: state.exercises, allExerciseBloc: allExercisesBloc,);
        }
        else if(state is ExercisesByCategoryOperationSuccess){
            return Container();
        }
        else if(state is ExercisesByCategoryOperationFailure){
          return Center(child: Text(state.message));
        }
        else{
          return Container();
        }
      }
    );
  }
}