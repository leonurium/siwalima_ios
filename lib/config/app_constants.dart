import 'package:flutter/material.dart';
//import 'package:siwalima/pages/under_maintenance.dart';
import '../pages/views/home_view.dart';
import '../pages/views/kategori_view.dart';
import '../pages/views/search_view.dart';

class AppConstans {
  static const appName = "Siwalimanews";

  static List<Map> navMenu = [
    {
      'view'  : const HomeView(),
      'icon'  : Icons.home_outlined,
      'label' : 'Home',
    },
    /* {
      'view'  : const UnderMaintenance(),
      'icon'  : Icons.bookmarks_outlined,
      'label' : 'Bookmarks',
    }, */
    {
      'view'  : const SearchView(),
      'icon'  : Icons.search_outlined,
      'label' : 'Search',
    },
    {
      'view'  : const KategoriView(),
      'icon'  : Icons.category_outlined,
      'label' : 'Kategori',
    },
    /* {
      'view'  : const UnderMaintenance(),
      'icon'  : Icons.person_outline_rounded,
      'label' : 'Profile',
    }, */
  ];
}