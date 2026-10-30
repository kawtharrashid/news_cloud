import 'package:news_cloud/features/data_layer/models/category_model.dart';

const String imagesPath = 'assets/images';
const List<CategoryModel> kCategories = [
  CategoryModel(
    image: '$imagesPath/business.png',
    category: 'Business',
  ),
  CategoryModel(
    image: '$imagesPath/entertainment.png',
    category: 'Entertainment',
  ),
  CategoryModel(
    image: '$imagesPath/health.png',
    category: 'Health',
  ),
  CategoryModel(
    image: '$imagesPath/science.png',
    category: 'Science',
  ),
  CategoryModel(
    image: '$imagesPath/technology.png',
    category: 'Technology',
  ),
  CategoryModel(
    image: '$imagesPath/sports.png',
    category: 'Sports',
  ),
  CategoryModel(
    image: '$imagesPath/general.png',
    category: 'General',
  ),
];
const String roboto = 'Roboto';
const defaultCategory = 'general';
