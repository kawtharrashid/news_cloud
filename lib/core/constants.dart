import 'package:flutter/material.dart';
import 'package:news_cloud/features/data_layer/models/category_model.dart';

const List<CategoryModel> kCategories = [
  CategoryModel(
    image: 'assets/business.avif',
    category: 'Business',
  ),
  CategoryModel(
    image: 'assets/entertaiment.avif',
    category: 'Entertainment',
  ),
  CategoryModel(
    image: 'assets/health.avif',
    category: 'Health',
  ),
  CategoryModel(
    image: 'assets/science.avif',
    category: 'Science',
  ),
  CategoryModel(
    image: 'assets/technology.jpeg',
    category: 'Technology',
  ),
  CategoryModel(
    image: 'assets/sports.avif',
    category: 'Sports',
  ),
  CategoryModel(
    image: 'assets/general.avif',
    category: 'General',
  ),
];

const Color kAppColor = Color(0xffFFEAAE);
const defaultCategory = 'general';
const Color kBackGroundColor = Color(0xffF2F4F3);
