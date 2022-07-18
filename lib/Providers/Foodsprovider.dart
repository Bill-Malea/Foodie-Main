import 'package:flutter/material.dart';
import 'package:foodie/Models/foodModel.dart';

class FoodsProvider extends ChangeNotifier {
  final List<FoodModel> _allfoods = [
    FoodModel(
      category: 'cccc',
      typeFood: 'Pizza',
      desc: 'jhhvvjv',
      image:
          'https://media.istockphoto.com/photos/diverse-keto-dishes-picture-id1280158821?b=1&k=20&m=1280158821&s=170667a&w=0&h=ibwKxBzWcygq6NMKO5FTD-3ljLvwM8E1WVevw7XSmlk=',
    
   
      price: '100',
      quantity: 2,
      timeFood: '10 Min',
      title: 'Fries',
      id: 'F100',
    ),
    FoodModel(
      category: 'cccc',
      typeFood: 'Pizza',
      desc: 'jhhvvjv',
      image:
          'https://metropoltv.co.ke/wp-content/uploads/2022/02/AdobeStock_176847641-1200x800-1-1100x733.jpeg',
    
      price: '100',
      quantity: 2,
      timeFood: '30 Min',
      title: 'Smokie',
      id: 'S100',
    ),
    FoodModel(
      category: 'cccc',
      typeFood: 'Pizza',
      desc: 'jhhvvjv',
      image:
          'https://media.istockphoto.com/photos/spicy-deep-fried-breaded-chicken-wings-picture-id583848484?k=20&m=583848484&s=612x612&w=0&h=oS5NY9C48rsgQEoNn-m55kpL4SpkBD5fhsnuEq-xGq4=',
   
      price: '100',
      quantity: 2,
      timeFood: '25 Min',
      title: 'Chicken',
      id: 'C100',
    ),
    FoodModel(
      category: 'cccc',
      typeFood: 'Pizza',
      desc: 'jhhvvjv',
      image:
          'https://metropoltv.co.ke/wp-content/uploads/2022/02/AdobeStock_176847641-1200x800-1-1100x733.jpeg',
    
      price: '100',
      quantity: 2,
      timeFood: '15 Min',
      title: 'Smokie',
      id: 'S200',
    ),
    FoodModel(
      category: 'cccc',
      typeFood: 'Pizza',
      desc: 'jhhvvjv',
      image:
          'https://metropoltv.co.ke/wp-content/uploads/2022/02/AdobeStock_176847641-1200x800-1-1100x733.jpeg',
      
      price: '100',
      quantity: 2,
      timeFood: '25 Min',
      title: 'Smokie',
      id: 'S300',
    )
  ];
  List<FoodModel> get allfoods {
    return [..._allfoods];
  }

  final List<FoodModel> _icecream = [
    FoodModel(
      category: 'cccc',
      typeFood: 'Pizza',
      desc: 'jhhvvjv',
      image: 'https://wallpapercave.com/wp/jLof3qL.jpg',
     
      price: '100',
      quantity: 2,
      timeFood: '20 Min',
      title: 'Vannila',
      id: 'V100',
    ),
    FoodModel(
      category: 'cccc',
      typeFood: 'Pizza',
      desc: 'jhhvvjv',
      image: 'https://wallpaperaccess.com/full/1279270.jpg',
     
      price: '100',
      quantity: 2,
      timeFood: '30 Min',
      title: 'Strawberry',
      id: 'SI100',
    ),
    FoodModel(
      category: 'cccc',
      typeFood: 'Pizza',
      desc: 'jhhvvjv',
      image:
          'https://c8.alamy.com/comp/MN6C09/chocolate-and-almond-ice-pops-in-a-cluster-overhead-scene-over-a-slate-background-MN6C09.jpg',
      price: '100',
      quantity: 2,
      timeFood: '20 Min',
      title: 'Popsicle',
      id: 'P100',
    ),
    FoodModel(
      category: 'cccc',
      typeFood: 'Pizza',
      desc: 'jhhvvjv',
      image:
          'https://p4.wallpaperbetter.com/wallpaper/108/450/541/food-ice-cream-berry-blueberry-wallpaper-preview.jpg',
      price: '100',
      quantity: 2,
      timeFood: '30 Min',
      title: 'Strawberry',
      id: 'SO100',
    ),
  ];

  List<FoodModel> get iceCream {
    return [..._icecream];
  }
}
