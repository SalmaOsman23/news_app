import 'package:flutter/material.dart';
import 'package:news_app1/data/model/CategoryDM.dart';
import 'package:news_app1/providers/my_provider.dart';
import 'package:news_app1/ui/widgets/category_widget/category_widget.dart';

class CategoriesTab extends StatelessWidget {
  final Function(CategoryDM) onCategoryClick;

  CategoriesTab(this.onCategoryClick, {super.key});

  late MyProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Pick your category of interest",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                itemCount: CategoryDM.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        onCategoryClick(
                          CategoryDM.categories[index],
                        );
                      },
                      child: CategoryWidget(
                          categoryDM: CategoryDM.categories[index]));
                }),
          ),
        )
      ],
    );
  }
}
