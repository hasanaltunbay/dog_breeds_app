import 'package:dog_breeds_app/helpers/bottom_to_top_page_route.dart';
import 'package:dog_breeds_app/helpers/my_text_field.dart';
import 'package:dog_breeds_app/pages/bottom_sheet_page.dart';
import 'package:dog_breeds_app/pages/splash_screen.dart';
import 'package:dog_breeds_app/pages/settings_page.dart';
import 'package:dog_breeds_app/service/dog_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Map<String, String> dogImages;

  HomePage({required this.dogImages});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var tfController = TextEditingController();

  List pages = [
    SplashScreen(),
    SettingsPage(),
  ];

  List<String> allBreeds = [];
  List<String> filteredList = [];

  void updateFilteredList(String text) {
    setState(() {
      filteredList = widget.dogImages.keys
          .where((breed) => breed.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    allBreeds = widget.dogImages.keys.toList();
    filteredList = allBreeds;
    super.initState();
  }

  Future<List<String>> getSubBreeds(String breed) async {
    return await DogService().fetchSubBreeds(breed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Breeds'),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No results found",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Text("Try searching with another word",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  )
                : GridView.builder(
                    itemCount: filteredList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      final breed = filteredList[index];
                      final imageUrl = widget.dogImages[breed];
                      final subBreed = getSubBreeds(breed);

                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              shape: OutlineInputBorder(),
                              enableDrag: false,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: BottomSheetPage(
                                      imageUrl: imageUrl,
                                      breed: breed,
                                      subBreed: subBreed),
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(alignment: Alignment.center, children: [
                            Image.network(
                              imageUrl!,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text("No data"),
                                );
                              },
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.black26),
                                child: Text(breed,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: MyTextField(
                      controller: tfController,
                      onChanged: (value) {
                        setState(() {
                          tfController.text = value;
                        });
                        updateFilteredList(value);
                      }),
                ),
              ),
              Positioned(
                  bottom: 25,
                  child: IconButton(
                    icon: Icon(Icons.arrow_upward_rounded),
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: OutlineInputBorder(),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.90,
                              child: Scaffold(
                                body: Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.arrow_downward)),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MyTextField(
                                          controller: tfController,
                                          onChanged: (value) {
                                            setState(() {
                                              tfController.text = value;
                                            });
                                            updateFilteredList(value);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  )),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 35,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 35,
              ),
              label: "Settings"),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).push(BottomToTopPageRoute(child: SettingsPage()));
          }
        },
      ),
    );
  }
}
