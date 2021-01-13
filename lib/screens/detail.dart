import 'package:flutter/material.dart';
import 'package:pokedexapp/models/pokemon.dart';


class Details extends StatelessWidget {
  Pokemon poke;
  Details({
    this.poke,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
//
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white70,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Center(child: CourseName(courseName: poke.name)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return keyOfCodesComponent(id: poke.id, type:poke.type,);
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.white70,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildUpCard(),
              buildStatsCard(),
              SizedBox(height: 20),
              buildWeaknesses(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Column buildWeaknesses() {
    return Column(
      children: [
        Text(
          'Weaknesses',
          style: const TextStyle(
            color: Color(0xFFffd66b),
            fontSize: 40.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: poke.weaknesses
              .map(
                (t) => FilterChip(
                  selected: false,
                  avatarBorder: Border.all(color: Colors.red),
                  backgroundColor: Colors.grey[850],
                  selectedShadowColor: Colors.red,
                  shadowColor: Colors.red,
                  selectedColor: Colors.red,
                  label: Text(
                    t,
                    style: TextStyle(color: Colors.white),
                  ),
                  onSelected: (b) {},
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Container buildStatsCard() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Column(


            children: <Widget>[

              Divider(
                color: Colors.white70,
                thickness: 3,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child:Text(
              'Stats',
              style: const TextStyle(
                color: Color(0xFFffd66b),
                fontSize: 40.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 5),
          StatusPanel(
            title: 'AVG SPAWNS',
            panelColor: Color(0xFF52575d),
            textColor: Colors.white70,
            count: '${poke.avgSpawns}',
          ),
          StatusPanel(
            title: 'EGGS',
            panelColor: Color(0xFF52575d),
            textColor: Colors.white70,
            count: '${poke.egg}',
          ),

          StatusPanel(
            title: 'HEIGHT',
            panelColor: Color(0xFF52575d),
            textColor: Colors.white70,
            count: '${poke.height}',
          ),
          StatusPanel(
            title: 'WEIGHT',
            panelColor: Color(0xFF52575d),
            textColor: Colors.white70,
            count: '${poke.weight}',
          ),



          SizedBox(height: 10),
          Column(


                  children: <Widget>[

                    Divider(
                        color: Colors.white70,
                     thickness: 3,
                    )
                  ],
          ),



          StatusPanel(
            title: 'CANDY',
            panelColor: Color(0xFF52575d),
            textColor: Colors.white70,
            count: '${poke.candy}',
          ),
          StatusPanel(
            title: 'CANDY COUNT',
            panelColor: Color(0xFF52575d),
            textColor: Colors.white70,
            count: '${poke.candyCount}',
          ),
          Column(


            children: <Widget>[

              Divider(
                color: Colors.white70,
                thickness: 3,
              )
            ],
          ),

        ],
      ),
    );
  }

  Padding buildUpCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(tag: poke.img, child: Image.network(poke.img)),
          //SizedBox(width: 10),
        ],
      ),
    );
  }



}



class CourseName extends StatelessWidget {
  final String courseName;

  CourseName({@required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            courseName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFd92027),
              fontSize: 40.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}


class keyOfCodesComponent extends StatelessWidget {
  final int id;
  final List<String> type;
  keyOfCodesComponent({@required this.id, this.type});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(20.0),
      ),
      content: SingleChildScrollView(
        child: Padding(

          padding: const EdgeInsets.only(
              left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
          child: Container(

            child: Column(



              children: [
                Center(
                    child: Text(
                      'PokeData',
                      style: TextStyle(
                        color:  Color(0xFFd92027),
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                      //style: codesExplainedStyle,
                    )),
                Divider(
                  color: Colors.black,
                  height: 20,
                  thickness: 3,
                  indent: 10,
                  endIndent: 10,
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Text(
                      'Pokemon ID :',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFffd66b),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),

                    ),
                    Text(
                      ' #'+'${this.id}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Color(0xFFffd66b),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),

                    ),

                  ],

                ),

                SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: this.type
                .map(
                  (t) => FilterChip(
                selected: false,
                avatarBorder: Border.all(color: Colors.red),
                backgroundColor: Colors.grey[850],
                label: Text(
                  t,
                  style: TextStyle(color: Colors.white),
                ),
                onSelected: (b) {},
              ),
            )
                .toList(),
          ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}



class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      { this.panelColor, this.textColor, this.title, this.count});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: double.infinity,
      color: panelColor,
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
          Text(
            count,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          )
        ],
      ),
    );
  }
}
