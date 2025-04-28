import 'package:flutter/material.dart';
import 'package:third_exam/main.dart';
import 'ingredients.dart';

class RecipeListScreen extends StatelessWidget {
    final Set<Map<String, dynamic>> recipes;
    final String category;

    const RecipeListScreen({super.key, required this.recipes, required this.category});

    @override
    Widget build(BuildContext context) {
        // TODO: Three recipes from the JSON file are shown on the second screen.
        List<Map<String, dynamic>> limitedRecipes = recipes.take(3).toList();

        return Scaffold(
            appBar: AppBar(
                title: Text('${getCategoryFlag(category)}-Recipes'),
                backgroundColor: Colors.lightGreen
            ),
            body: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: limitedRecipes.length,
                itemBuilder: (context, index) {
                    final recipe = limitedRecipes.elementAt(index);
                    String recipeName =recipe['name']!;
                    return Card(
                        child: ListTile(
                            leading: Text(
                                ("#${index + 1}"),
                                style: const TextStyle(fontSize: 16)
                            ),
                            title: Text(
                                recipeName,
                                style: const TextStyle(fontSize: 24)
                            ),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {
                                List<String> ingredients = List<String>.from(recipe['ingredients']);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => IngredientsScreen(name: recipeName, ingredients: ingredients))
                                );
                            }
                        )
                    );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider()
            ),
            backgroundColor: Colors.grey
        );
    }
}