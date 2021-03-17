import 'package:FoodRecipes/models/category.dart';
import 'package:FoodRecipes/models/cuisine.dart';
import 'package:FoodRecipes/models/recipe.dart';
import 'package:FoodRecipes/screens/recipe_add_screen.dart';
import 'package:FoodRecipes/screens/categories_screen.dart';
import 'package:FoodRecipes/screens/cuisine_screen.dart';
import 'package:FoodRecipes/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../translation/app_localizations.dart';
import 'settings_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  final List<Recipe> mostCollected;
  final List<Recipe> recentRecipesWithLimit;
  final List<Recipe> allRecipes;
  final List<Recipe> recentRecipes;
  final List<Category> categories;
  final List<Cuisine> cuisine;
  final BuildContext loginContext;

  TabsScreen(
      {this.allRecipes,
      this.recentRecipesWithLimit,
      this.recentRecipes,
      this.categories,
      this.cuisine,
      this.mostCollected,
      this.loginContext});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        _pages[_selectedPageIndex]['title'],
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: <Widget>[
        _pages[_selectedPageIndex]['page'],
      ],
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      onTap: _selectPage,
      elevation: 0,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black26,
      selectedItemColor: Theme.of(context).primaryColor,
      currentIndex: _selectedPageIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/ic_home.png', scale: 2.2),
          activeIcon:
              Image.asset('assets/images/ic_home_filled.png', scale: 2.2),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/ic_category.png', scale: 2.2),
          activeIcon:
              Image.asset('assets/images/ic_category_filled.png', scale: 2.2),
          title: Text('Categories'),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/ic_add.png', scale: 2.2),
          activeIcon:
              Image.asset('assets/images/ic_add_filled.png', scale: 2.2),
          title: Text('Add Recipe'),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/ic_country.png', scale: 2.2),
          activeIcon:
              Image.asset('assets/images/ic_country_filled.png', scale: 2.2),
          title: Text('Cuisine'),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/ic_profile.png', scale: 1.9),
          activeIcon:
              Image.asset('assets/images/ic_profile_filled.png', scale: 1.9),
          title: Text('CookBook'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      {
        'page': HomeScreen(
          mostCollectedRecipes: widget.mostCollected,
          allRecipes: widget.allRecipes,
        ),
        'title': AppLocalizations.of(context).translate('home'),
      },
      {
        'page': CategoriesScreen(
          categories: widget.categories,
        ),
        'title': AppLocalizations.of(context).translate('categories'),
      },
      {
        'page': AddRecipeScreen(),
        'title': 'Add Recipe',
      },
      {
        'page': CuisineScreen(widget.cuisine),
        'title': AppLocalizations.of(context).translate('cuisine'),
      },
      {
        'page': SettingsScreen(),
        'title': '',
      },
    ];
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: _body(context),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }
}
