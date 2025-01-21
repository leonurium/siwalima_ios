import 'package:flutter/material.dart';

class ListKategory {
  final String name;
  final IconData icon;
  final int idkategori;

  ListKategory(this.name, this.icon, this.idkategori);
}

final List<ListKategory> categories = [
  ListKategory("Kriminal", Icons.gavel, 36),
  ListKategory("Politik", Icons.account_balance, 38),
  ListKategory("Daerah", Icons.location_on, 37),
  ListKategory("Pendidikan", Icons.school, 41),
  ListKategory("Hukum", Icons.balance, 42),
  ListKategory("Pemerintahan", Icons.business_sharp, 43),
  ListKategory("Visi", Icons.visibility, 25),
  ListKategory("Olahraga", Icons.sports_soccer, 31),
  ListKategory("Opini", Icons.comment, 285),
  ListKategory("Online", Icons.language, 301),
  ListKategory("Covid-19", Icons.coronavirus, 52),];