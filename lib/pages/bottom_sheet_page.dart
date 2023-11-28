import 'package:dog_breeds_app/service/dog_service.dart';
import 'package:flutter/material.dart';

class BottomSheetPage extends StatelessWidget {
  String imageUrl;
  String breed;
  Future<List<String>> subBreed;

  BottomSheetPage(
      {required this.imageUrl, required this.breed, required this.subBreed});

  Future<String> getRandomImageForBreed(String breed) async {
    return await DogService().fetchRandomImageForBreed(breed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
         margin: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Image.network(
                    imageUrl,
                    height: 300,
                    width: 500,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 3,
                    right: 3,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text("Breed",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                  Divider(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(breed,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text("Sub Breed",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                  Divider(height: 5,),
                  Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: FutureBuilder<List<String>>(
                        future: subBreed,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<String> subBreeds = snapshot.data ?? [];
                            if (subBreeds.isEmpty) {
                              subBreeds = ['Sub Breed 1', 'Sub Breed 2'];
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: subBreeds.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    subBreeds[index],
                                    style: TextStyle(fontSize: 15, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            );
                          }
                        },
                      )
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0,right: 10,left: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(300, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        onPressed: () {
                          getRandomImageForBreed(breed)
                              .then((String newImageUrl) {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                enableDrag: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: MediaQuery.of(context).size.height,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            newImageUrl,
                                            width: 300,
                                            height: 300,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(height: 20,),
                                          Center(
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.white),
                                              child: IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }).catchError((error) {
                            print("error: $error");
                          });
                        },
                        child: Text("Generate", style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
