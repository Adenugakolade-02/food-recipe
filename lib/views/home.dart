import 'package:flutter/material.dart';
import 'package:food_recipe/models/recipe.api.dart';
import 'package:food_recipe/models/recipe.dart';
import 'package:food_recipe/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Recipe> _recipes;
  
  bool _isloading = true;

  Future<void> getRecipes() async{
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isloading=false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Icon(Icons.restaurant_menu),
          const SizedBox(width: 10),
          const Text("Food Recipe"),
        ],),
      ),
      
      body: _isloading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount: _recipes.length,
            itemBuilder: (context, index){
              return RecipeCard(
                title: _recipes[index].name,
                cookTime: _recipes[index].totalTime,
                rating: _recipes[index].rating.toString(),
                thumbnailUrl: _recipes[index].imageUrl,);
            })

    );
  }
}