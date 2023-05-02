import '../models/model.dart';
import '../repository/repository.dart';

class GetMovies {
  List<MoviesClass> listMovies = [];
  List<MoviesClass> listPopular = [];

  Repository repository = Repository();

  getTopRatedList() async {
    listMovies = await repository.loadTopRatedMovies();
    return listMovies;
  }

  getPopularMovieList() async {
    listPopular = await repository.loadPopularMovies();
    return listPopular;
  }
}
