import 'package:news_cloud/features/data_layer/models/category_model.dart';

const String imagesPath = 'assets/images';
const List<CategoryModel> kCategories = [
  CategoryModel(
    image: '$imagesPath/business.avif',
    category: 'Business',
  ),
  CategoryModel(
    image: '$imagesPath/entertaiment.avif',
    category: 'Entertainment',
  ),
  CategoryModel(
    image: '$imagesPath/health.avif',
    category: 'Health',
  ),
  CategoryModel(
    image: '$imagesPath/science.avif',
    category: 'Science',
  ),
  CategoryModel(
    image: '$imagesPath/technology.jpeg',
    category: 'Technology',
  ),
  CategoryModel(
    image: '$imagesPath/sports.avif',
    category: 'Sports',
  ),
  CategoryModel(
    image: '$imagesPath/general.avif',
    category: 'General',
  ),
];
const String roboto = 'Roboto';
const defaultCategory = 'general';
