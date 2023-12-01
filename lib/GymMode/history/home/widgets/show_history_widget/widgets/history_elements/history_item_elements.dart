import 'package:flutter/material.dart';
import 'package:history_repository/history_repository.dart';
import 'header_tile.dart';

/*
* Main description:
This class is used to display training history records
 */

class HistoryItemElements extends StatefulWidget {
  const HistoryItemElements({super.key, required this.elements});

  //history records for specific training
  final List<History> elements;

  @override
  State<HistoryItemElements> createState() => _HistoryItemElementsState();
}

class _HistoryItemElementsState extends State<HistoryItemElements> {
  List<bool> isExpanded = <bool>[];
  static const mainColor = Color.fromARGB(255, 79, 171, 151);

  @override
  void initState() {

    //isExpanded list is initialized with false values for all elements and later used to check if the element is expanded or not
    isExpanded = List.generate(widget.elements.length, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30.0),
            HeaderTitle(title: widget.elements.first.name,),
            const SizedBox(height: 15.0),

            //this is custom container, used to allow widgets to expand and collapse
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.bento_rounded, size: 100.0, color: mainColor,
                    shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(-1, 1), blurRadius: 1)],
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text("${widget.elements[index].name}  ${widget.elements[index].date.toDate().toString()}",
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        onExpansionChanged:  (_) { setState(() {
                          isExpanded[index] = !isExpanded[index];
                          });
                        },
                        leading: isExpanded[index]
                            ? const Icon(Icons.auto_stories, color: mainColor, size: 30,
                          shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(-1, 1), blurRadius: 2)],
                        )
                            : const Icon(Icons.touch_app_sharp, color: mainColor, size: 30,
                          shadows: <Shadow>[Shadow(color: Colors.black, offset: Offset(-1, 1), blurRadius: 2)],
                        ),
                        iconColor: mainColor,

                        //this is the body of the tile when it is expanded
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "Date: ",
                                          style: Theme.of(context).textTheme.titleLarge
                                      ),
                                      TextSpan(
                                        text: widget.elements[index].date.toDate().toString().substring(0, 19),
                                        style: Theme.of(context).textTheme.headlineMedium,
                                      ),
                                    ],
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                                for(int n =0; n < widget.elements[index].exercises_name.length; n++)
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      const SizedBox(height: 10.0),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                                text: "Exercise name: ",
                                                style: Theme.of(context).textTheme.titleLarge
                                            ),
                                            TextSpan(
                                              text: widget.elements[index].exercises_name[n],
                                              style: Theme.of(context).textTheme.headlineMedium,
                                            ),
                                          ],
                                        ),
                                        overflow: TextOverflow.clip,
                                      ),
                                      widget.elements[index].exercises_sets_count.length > n
                                          && widget.elements[index].exercises_sets_count[n] != null
                                          && widget.elements[index].exercises_sets_count[n] != 0 ?
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                                text: "Sets: ",
                                                style: Theme.of(context).textTheme.titleLarge
                                            ),
                                            TextSpan(
                                              text:  widget.elements[index].exercises_sets_count[n].toString(),
                                              style: Theme.of(context).textTheme.headlineMedium,
                                            ),
                                          ],
                                        ),
                                        overflow: TextOverflow.clip,
                                      ) : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 16.0),
                                            Text("Exercise was not made", style: Theme.of(context).textTheme.headlineSmall,)
                                          ]
                                      ),
                                      widget.elements[index].exercises_sets_count.length > n
                                          && widget.elements[index].exercises_sets_count[n] != null
                                          && widget.elements[index].exercises_sets_count[n] != 0 ?
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                                text: "Weights: ",
                                                style: Theme.of(context).textTheme.titleLarge
                                            ),
                                            TextSpan(
                                              //text: widget.elements[index].exercises_weights[n] == null ? "Exercise was not made" : widget.elements[index].exercises_weights[n].toString(),
                                              text:  widget.elements[index].exercises_weights[n],
                                              style: Theme.of(context).textTheme.headlineMedium,
                                            ),
                                          ],
                                        ),
                                        overflow: TextOverflow.clip,
                                      ) : const Text(""),
                                      const SizedBox(height: 8.0),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
                    separatorBuilder: (_, __) => const SizedBox(height: 20.0),
                    itemCount: widget.elements.length,
                  ),
                ]
              )
            ),

          ],
        ),
      )
    );
  }
}