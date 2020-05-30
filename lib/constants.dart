import 'model/points.dart';

class AppConstants {
  static const String TITLE = 'Yatzy Lappen';

  static const String ADD_PLAYER_DESCRIPTION =
      'Lägg till en spelare i taget, eller seprarera namen med kommatecken för att lägga till flera spelare samtidigt.';

  static const String BUTTON_CLOSE = 'Klar';
  static const String BUTTON_ADD = 'Lägg till';

  static const String NAME = 'Namn';

  static const String SNACKBAR_GOT = 'fick';
  static const String SNACKBAR_POINTS_ON = 'poäng på';
  static const String SCRATCHED = 'strök';

  static const String ONES = 'Ettor';
  static const String TWOS = 'Tvåor';
  static const String THREES = 'Treor';
  static const String FOURS = 'Fyror';
  static const String FIVES = 'Femmor';
  static const String SIXES = 'Sexor';
  static const String TOP_SUM = 'Summa';
  static const String BONUS = 'Bonus';
  static const String PAIR = 'Ett par';
  static const String TWO_PAIRS = 'Två par';
  static const String TRIPS = 'Tretal';
  static const String FOUR_OF_A_KIND = 'Fyrtal';
  static const String FULL_HOUSE = 'Kåk';
  static const String SMALL_STRAIGHT = 'Liten stege';
  static const String LARGE_STRAIGHT = 'Stor stege';
  static const String CHANCE = 'Chans';
  static const String YATZY = 'Yatzy';
  static const String TOTAL = 'Poäng';

  static const Map<PointTypes, String> CELL_NAMES = {
    PointTypes.ONES: AppConstants.ONES,
    PointTypes.TWOS: AppConstants.TWOS,
    PointTypes.THREES: AppConstants.THREES,
    PointTypes.FOURS: AppConstants.FOURS,
    PointTypes.FIVES: AppConstants.FIVES,
    PointTypes.SIXES: AppConstants.SIXES,
    PointTypes.TOP_SUM: AppConstants.TOP_SUM,
    PointTypes.BONUS: AppConstants.BONUS,
    PointTypes.PAIR: AppConstants.PAIR,
    PointTypes.TWO_PAIRS: AppConstants.TWO_PAIRS,
    PointTypes.TRIPS: AppConstants.TRIPS,
    PointTypes.FOUR_OF_A_KIND: AppConstants.FOUR_OF_A_KIND,
    PointTypes.FULL_HOUSE: AppConstants.FULL_HOUSE,
    PointTypes.SMALL_STRAIGHT: AppConstants.SMALL_STRAIGHT,
    PointTypes.LARGE_STRAIGHT: AppConstants.LARGE_STRAIGHT,
    PointTypes.CHANCE: AppConstants.CHANCE,
    PointTypes.YATZY: AppConstants.YATZY,
    PointTypes.TOTAL: AppConstants.TOTAL,
  };

  static const Map<PointTypes, List<int>> POSSIBLE_POINTS = {
    PointTypes.ONES: [1, 2, 3, 4, 5],
    PointTypes.TWOS: [2, 4, 6, 8, 10],
    PointTypes.THREES: [3, 6, 9, 12, 15],
    PointTypes.FOURS: [4, 8, 12, 16, 20],
    PointTypes.FIVES: [5, 10, 15, 20, 25],
    PointTypes.SIXES: [6, 12, 18, 24, 30],
    PointTypes.PAIR: [2, 4, 6, 8, 10, 12],
    PointTypes.TWO_PAIRS: [6, 8, 10, 12, 14, 16, 18, 20, 22],
    PointTypes.TRIPS: [3, 6, 9, 12, 15, 18],
    PointTypes.FOUR_OF_A_KIND: [4, 8, 12, 16, 20, 24],
    PointTypes.FULL_HOUSE: [
      7,
      9,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      21,
      22,
      23,
      24,
      26,
      27,
      28
    ],
    PointTypes.SMALL_STRAIGHT: [15],
    PointTypes.LARGE_STRAIGHT: [20],
    PointTypes.CHANCE: [
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30
    ],
    PointTypes.YATZY: [50],
  };
}
