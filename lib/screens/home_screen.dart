import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokedexapp/models/pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:pokedexapp/screens/detail.dart';

import 'package:pokedexapp/widgets/loading.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var url =
      'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json';

  PokeDatabase pokedb;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var result = await http.get(url);
    var customJsonDecoder = jsonDecode(result.body);
    pokedb = PokeDatabase.fromJson(customJsonDecoder);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xFFffd66b),
        body: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            _buildHeader(screenHeight),
            _buildPokemonPanel(screenHeight),

          ],

        )
    );
//    return Scaffold(
//      backgroundColor: Colors.grey[900],
//      appBar: customAppBar('MiPokedex', null),
//      body: pokedb == null ? Loading(size: 100) : mainScreen(context),
//    );
  }


  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(



      child: Container(




        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color(0xFFd92027),


          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top:30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Pokédex',
                    style: const TextStyle(
                      color: Colors.white70  ,
                      fontSize:30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Gotta catch em' all!",
                    style: const TextStyle(
                      color: Color(0XFFff8585),
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ],
              )

            ],
          ),
        ),


      ),
    );
  }

  SliverToBoxAdapter _buildPokemonPanel(double screenHeight){
    return SliverToBoxAdapter(
      child: Container(
        height: 550,
        padding: const EdgeInsets.fromLTRB(0,10, 0, 15),

            child: GridView.count(
              crossAxisCount: 2,
              children: pokedb.pokemon
                  .map(
                    (poke) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: InkWell(
                    splashColor: Colors.red,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(
                          poke: poke,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Container(
                        height: 240,
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              poke.img == null
                                  ? Loading(
                                size: 30,
                              )
                                  : Hero(
                                tag: poke.img,
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(poke.img),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                poke.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  .toList(),
            ),

      ),
    );

  }
}
