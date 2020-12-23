import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;
  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});
  final _pagecontroller =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pagecontroller.addListener(() {
      if (_pagecontroller.position.pixels >=
          _pagecontroller.position.maxScrollExtent - 200) {
        print("imprimir");
        siguientePagina();
      }
    });
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pagecontroller,
        //children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context, i) {
          return _crearTarjeta(context, peliculas[i]);
        },
      ),
    );
  }

  Widget _crearTarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = "${pelicula.id}-poster";
    final peliculaTarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 200.0,
                width: 300.0,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
      child: peliculaTarjeta,
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 200.0,
                width: 300.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}
