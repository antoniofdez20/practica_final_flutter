import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  List<User> users = [
    User("Alice", 150),
    User("Bob", 200),
    User("Charlie", 300),
    User("Diana", 250),
    User("Ethan", 700),
    User("Clara", 400),
    User("Pedro", 300),
    User("Serbal", 450),
    User("Trip", 250),
  ];

  List<User> filteredUsers = [];
  double _opacity = 0.0; 

  @override
  void initState() {
    super.initState();
    sortUsers();
    filterTopFive(); 
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0; 
      });
    });
  }

  void sortUsers() {
    users.sort((a, b) => b.score.compareTo(a.score));
  }

  void filterTopFive() {
    setState(() {
      filteredUsers = users.take(5).toList();
    });
  }

  void filterUsers(String query) {
    if (query.isNotEmpty) {
      List<User> tmpList = users.where((user) =>
        user.name.toLowerCase().contains(query.toLowerCase())).toList();
      setState(() {
        filteredUsers = tmpList.take(5).toList(); // Limita a los 5 primeros después de filtrar
      });
    } else {
      filterTopFive();
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // No hace nada porque ya estamos en la pantalla de Ranking
        break;
      case 1:
        Get.toNamed('/home'); // Navega a la pantalla de Inicio
        break;
      case 2:
        Get.toNamed('/store'); // Navega a la pantalla de la Tienda
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: filterUsers,
                decoration: InputDecoration(
                  labelText: 'Filtrar por nombre',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '🏆 TOP 5 Ranking',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 2),
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    dataRowHeight: 60,
                    headingRowColor: MaterialStateProperty.all(Colors.deepPurple[100]),
                    columns: const [
                      DataColumn(label: Text('Posición')),
                      DataColumn(label: Text('Nombre')),
                      DataColumn(label: Text('Puntaje')),
                    ],
                    rows: filteredUsers.map<DataRow>((user) {
                      int position = users.indexOf(user) + 1;
                      return DataRow(
                        color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return (position % 2 == 0) ? Colors.deepPurple[50] : null;
                          },
                        ),
                        cells: [
                          DataCell(Text('$position')),
                          DataCell(Text(user.name)),
                          DataCell(Text('${user.score}')),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Ranking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

class User {
  final String name;
  final int score;

  User(this.name, this.score);
}
