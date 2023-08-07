import '../models/category_model.dart';

enum AuthStatus { pending, successful, exists, noUser, wrongPass, failed }
enum CartStatus { success, failed }
enum Status { success, failed }

List<Categories> categories = [
  Categories(
    image: 'ice-cream.png',
    title: 'Ice Creams',
  ),
  Categories(
    image: 'ice-cream2.png',
    title: 'Ice Cream Bars',
  ),
  Categories(
    image: 'sweets.png',
    title: 'Candies',
  ),
  Categories(
    image: 'cake.png',
    title: 'Cakes',
  ),
];

List<String> countryCodes = [
  '+91',
  '+94',
  '+92',
  '+86',
  '+61',
  '+44',
  '+1',
  '+977',
  '+880',
  '+975'
];

const String nameKey = 'name';
const String emailKey = 'email';
const String locationKey = 'location';
