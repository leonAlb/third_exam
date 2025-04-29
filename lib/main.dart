import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'recipe_list_screen.dart';

import 'dart:convert';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Third Portfolio Exam',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
                useMaterial3: true
            ),
            home: MyHomePage(title: 'Recipes from around the World')
        );
    }
}

class MyHomePage extends StatefulWidget {
    const MyHomePage({super.key, required this.title});
    final String title;

    @override
    State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    Map<String, dynamic> _data = {};
    Set<String> categories = {};

    @override
    void initState() {
        super.initState();
        _loadData();
    }

    void _loadData() async {
        _data = await loadJsonFromAssets(
            'assets/data/mobile-apps-portfolio-03-recipes.json'
        );
        setState(() {
                categories = _categories(_data);
            });
    }

    Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
        String jsonString = await rootBundle.loadString(filePath);
        return jsonDecode(jsonString);
    }

    Set<String> _categories(Map<String, dynamic> data) {
        return data['recipes']
            .map<String>((recipe) => recipe['category'] as String)
            .toSet();
    }

    Set<Map<String, dynamic>> _recipesOfCategory(Map<String, dynamic> data, String category) {
        return data['recipes']
            .where((recipe) => recipe['category'] == category)
            .cast<Map<String, dynamic>>()
            .toSet();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Choose a Category'),
                backgroundColor: Colors.lightGreen
            ),
            body: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                    final String category = categories.elementAt(index);
                    final String upperCaseCategory = capitalizeFirstLetter(category);
                    return Card(
                        child: ListTile(
                            leading: Text(
                                getCategoryFlag(category),
                                style: const TextStyle(fontSize: 32)
                            ),
                            title: Text(
                                upperCaseCategory,
                                style: const TextStyle(fontSize: 24)
                            ),
                            trailing: Text(
                                '#${index + 1}',
                                style: const TextStyle(fontSize: 18)
                            ),
                            onTap: () {
                                Set<Map<String, dynamic>> categoryRecipes = _recipesOfCategory(_data, category);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RecipeListScreen(
                                            recipes: categoryRecipes,
                                            category: upperCaseCategory
                                        )
                                    )
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

String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
}

String getCategoryFlag(String category) {
    switch (category.toLowerCase()) {
        case 'italian':
            return '🇮🇹';
        case 'indian':
            return '🇮🇳';
        case 'turkish':
            return '🇹🇷';
        default:
        return '🏳️';
    }
}