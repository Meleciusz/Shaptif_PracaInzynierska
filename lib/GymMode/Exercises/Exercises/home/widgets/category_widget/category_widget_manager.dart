import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/Exercises/Exercises/exercises.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget>{

  @override
  void initState(){
    BlocProvider.of<CategoryWidgetBloc>(context).add(GetCategories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CategoryWidgetBloc categoryWidgetBloc = BlocProvider.of<CategoryWidgetBloc>(context);

    return BlocBuilder<CategoryWidgetBloc, CategoryWidgetState>(
      builder: (context, state) {
        if(state is CategoryWidgetLoading){
          return const Center(child: CircularProgressIndicator());
        }
        else if(state is CategoryWidgetLoaded){
          log("jestem tammmmmmmmmm");
          return CategoriesSuccessWidget(categories: state.categories);
        }
        else if(state is CategoryOperationSuccess){
          log("jestem tutajjjjjj");
          categoryWidgetBloc.add(GetCategories());
          return Container();
        }
        else if(state is CategoryOperationFailure){
          return Center(child: Text(state.message));
        }
        else{
          return Container();
        }
      }
    );
  }
}