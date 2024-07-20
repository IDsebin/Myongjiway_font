import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _searchHistory = [];

  void _addSearchTerm(String term) {
    setState(() {
      if (_searchHistory.contains(term)) {
        _searchHistory.remove(term);
      }
      _searchHistory.insert(0, term);
      if (_searchHistory.length > 5) {
        _searchHistory.removeRange(5, _searchHistory.length);
      }
    });
  }

  void _removeSearchTerm(String term) {
    setState(() {
      _searchHistory.remove(term);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 35,
            left: 10,
            right: 10,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/back.png',  //텍스트 추가(이건 시후한테 의견 물어보기)
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 10), // 이미지와 텍스트 필드 사이의 간격
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: '정류장 검색',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onSubmitted: (term) {
                        _addSearchTerm(term);
                        _searchController.clear();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 110,
            left: 10,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '최근 검색어',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                Column(
                  children: _searchHistory.map((term) {
                    return ListTile(
                      title: Text(term),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _removeSearchTerm(term);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
