import '../models/model.dart';
import '../repository/repository.dart';

class GetMovies {
  List<MoviesClass> listTopRatedMovies = [];
  List<MoviesClass> listPopular = [];
  List<MoviesClass> listTrending = [];

  Repository repository = Repository();

  getTopRatedList() async {
    listTopRatedMovies = await repository.loadTopRatedMovies();
    return listTopRatedMovies;
  }

  getPopularMovieList() async {
    listPopular = await repository.loadPopularMovies();
    return listPopular;
  }

  getTrending() async {
    listTrending = await repository.loadTrendingMovies();
    return listTrending;
  }
}
