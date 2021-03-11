import 'package:get/get.dart';
import 'package:online_games/models/Game.dart';
import 'package:online_games/utils/api.dart';
import 'package:online_games/utils/storage.dart';

class GameController extends GetxController {
  RxList<Game> allGames = List<Game>.empty().obs;
  Rx<Game> selectedGame = Game("", "", 0).obs;
  RxBool isInitiallized = false.obs;
  RxBool selectedGameExists = false.obs;

  @override
  void onInit() {
    API.getAllGames().then((value) {
      allGames.addAll(value.map((game) => Game.fromMap(game)));
      isInitiallized.value = true;
    });

    super.onInit();
  }

  void changeSelectedGame(String gameTitle) {
    try {
      Game newSelected = allGames
          .firstWhere((Game game) => game.title.compareTo(gameTitle) == 0);

      selectedGameExists.value = true;
      selectedGame.value = newSelected;
    } catch (error) {
      selectedGameExists.value = false;
    }
  }

  Future<bool> createNewBoard(String creator, String title, String? password,
      int? capacity, String gameTitle) async {
    await _handleToken();
    final boardMap =
        await API.createNewBoard(creator, title, password, capacity, gameTitle);

    if (boardMap != null) {
      return true;
    }

    return false;
  }

  Future<void> _handleToken() async {
    String? token = Storage.getValue(Storage.TOKEN);
    if (token != null) {
      var validationResult = await API.validateToken(token);
      if (validationResult != null) {
        return;
      }

      String? refreshToken = Storage.getValue(Storage.REFRESH_TOKEN);
      if (refreshToken != null) {
        var refreshResult = await API.getNewToken(refreshToken);
        if (refreshResult != null) {
          Storage.saveValue(Storage.TOKEN, refreshResult["token"]);
          Storage.saveValue(
              Storage.REFRESH_TOKEN, refreshResult["refreshToken"]);
        }
      }
    }
  }
}
