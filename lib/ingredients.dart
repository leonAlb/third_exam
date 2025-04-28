import 'package:flutter/material.dart';
import 'package:third_exam/main.dart';

class IngredientsScreen extends StatelessWidget {
    final List<String> ingredients;
    final String name;

    const IngredientsScreen({super.key, required this.ingredients, required this.name});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(name),
                backgroundColor: Colors.lightGreen
            ),
            body: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                    return ItemWidget(text: ingredients[index]);
                },
                separatorBuilder: (context, index) {
                    return Divider(); // Add a divider between items, you can customize it
                }
            ),
            backgroundColor: Colors.grey
        );
    }
}

class ItemWidget extends StatelessWidget {
    const ItemWidget({super.key, required this.text});

    final String text;

    @override
    Widget build(BuildContext context) {
        return Card(
            child: ListTile(
                title: Text(capitalizeFirstLetter(text),
                    style: const TextStyle(fontSize: 24)
                )
            )
        );
    }
}