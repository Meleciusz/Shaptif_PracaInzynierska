import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaptifii/GymMode/main_page/trainings/trainings/home/widgets/all_trainings_widget/bloc/all_trainings_widget_bloc.dart';
import 'package:training_repository/training_repository.dart';
import 'item.dart';

class TrainingsSuccessWidget extends StatefulWidget {
  const TrainingsSuccessWidget({super.key, required this.trainings});

  final List<Training>? trainings;

  @override
  State<TrainingsSuccessWidget> createState() => TrainingsSuccessWidgetState();
}

class TrainingsSuccessWidgetState extends State<TrainingsSuccessWidget> {
  TextEditingController editingController = TextEditingController();

  List<Training> items = <Training>[];

  @override
  initState() {
    items = widget.trainings!;
    super.initState();
  }

  void filterSearchResults(value) {
    setState(() {
      items = widget.trainings!
          .where((item) => item.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllTrainingsBloc, AllTrainingsState>(
        builder: (context, state){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value){
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: const InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular((25.0)))
                      )
                  ),
                ),
              ),
              widget.trainings!.isNotEmpty ?
              SizedBox(
                height: ((items.length * 100) + MediaQuery.of(context).size.width) + 24,
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                      left: 24.0,
                      right: 24.0,
                      top: 24.0,
                    ),
                  itemBuilder: (context, index){
                      return AllTrainingsItem(
                        training: items[index]
                      );
                  },
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 20.0,
                  ),
                  itemCount: items.length,
                )
              ) : SizedBox(
                height: 300,
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No trainings", style: Theme.of(context).textTheme.displaySmall,),
                  ]
                )
              ),
            ],
          );
        }
    );
  }
}