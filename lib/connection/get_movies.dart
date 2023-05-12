import '../models/model.dart';
import '../repository/repository.dart';

class GetMovies {
  List<MoviesClass> listTopRatedMovies = [];
  List<MoviesClass> listPopular = [];
  List<MoviesClass> listTrending = [];
  List<MoviesClass> listNowPlaying = [];
  List<MoviesClass> listTvPopular = [];
  List<MoviesClass> listUpcoming = [];

  Repository repository = Repository();

  getUpcomingMovieList() async {
    listUpcoming = await repository.loadUpcomingMovies();
    return listUpcoming;
  }

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

  getNowPlaying() async {
    listNowPlaying = await repository.loadNowPlaying();
    return listNowPlaying;
  }

  getTvPopular() async {
    listTvPopular = await repository.loadTvPopular();
    return listTvPopular;
  }
}
