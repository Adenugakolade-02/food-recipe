import 'dart:convert';
import 'package:food_recipe/models/recipe.dart';
import 'package:http/http.dart' as http;


class RecipeApi{

// url = "https://yummly2.p.rapidapi.com/feeds/list"

// querystring = {"limit":"24","start":"0"}

// headers = {
// 	"X-RapidAPI-Key": "158f206a76msh22514dc4cd706edp177b56jsn5ad33256c1af",
// 	"X-RapidAPI-Host": "yummly2.p.rapidapi.com"
// }

// response = requests.request("GET", url, headers=headers, params=querystring)

  static Future<List<Recipe>> getRecipe() async{
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', {"limit":"24","start":"0","tag":"list.recipe.popular"}); //for sending a http request
    
    final response = await http.get(uri,headers: {
	    "X-RapidAPI-Key": "158f206a76msh22514dc4cd706edp177b56jsn5ad33256c1af",
	    "X-RapidAPI-Host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
      });

    List _temp = [];
    if (response.statusCode==200){
      Map data = json.decode(response.body);
      
      for (var i in data['feed']){
        _temp.add(i['content']['details']);
      }
    }
  
    return Recipe.recipesFromSnapshot(_temp);
  }

}