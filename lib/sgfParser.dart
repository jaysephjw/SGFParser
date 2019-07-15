library sgf_parser;

import 'package:sgf_parser/boardSize.dart';
import 'package:sgf_parser/fileFormat.dart';
import 'package:sgf_parser/game.dart';
import 'package:sgf_parser/gameAttributes.dart';
import 'package:sgf_parser/gameType.dart';
import 'package:sgf_parser/move.dart';
import 'package:sgf_parser/player.dart';

class SGFParser {
  final String sgf;

  T _parse<T>(String attribute, T Function(String) converter, [T defaultVal]) {
    var exp = RegExp(attribute + r'\[(.*?)\]');
    var match = exp.firstMatch(sgf)?.group(1);

    if (match == null) {
      if (defaultVal == null) {
        return null;
      }
      return defaultVal;
    }
    return converter(match);
  }

  List<Move> _parseMoves() {
    var moves = <Move>[];
    var bExp = RegExp(r';(.?)\[(.*?)\]');
    var matches = bExp.allMatches(sgf);

    matches.forEach((match) {
      Player player = match.group(1) == 'B' ? Player.Black : Player.White;
      String moveString = match.group(2);

      Move move;
      if (moveString == '' || moveString == 'tt') {
        move = Move.pass(player);
      } else {
        move = Move(player, moveString[0], moveString[1]);
      }

      moves.add(move);
    });

    return moves;
  }

  GameAttributes _parseAttributes() {
    FileFormat ff = parseFileFormat();
    GameType type = parseGameType();
    BoardSize size = parseBoardSize(type);
    DateTime date = parseDate();
    String event = parseEvent();

    return GameAttributes(ff, date, type, size, event);
  }

  BoardSize parseBoardSize(GameType gameType) {
    BoardSize defaultValue;

    if (gameType == GameType.Go) {
      defaultValue = BoardSize.square(19);
    } else if (gameType == GameType.Chess) {
      defaultValue = BoardSize.square(8);
    }

    BoardSize size = _parse('SZ', (match) {
      if (match.contains(':')) {
        var exp = RegExp(r'(\d+?):(\d+)');
        var col = exp.firstMatch(match).group(1);
        var row = exp.firstMatch(match).group(2);

        return BoardSize(int.parse(col), int.parse(row));
      } else {
        return BoardSize.square(int.parse(match));
      }
    }, defaultValue);

    return size;
  }

  GameType parseGameType() {
    GameType type = _parse(
        'GM', (match) => GameType.values[int.parse(match) - 1], GameType.Go);
    return type;
  }

  FileFormat parseFileFormat() {
    FileFormat ff = _parse('FF',
        (match) => FileFormat.values[int.parse(match) - 1], FileFormat.FF1);
    return ff;
  }

  DateTime parseDate() {
    DateTime date = _parse('DT', DateTime.parse);
    return date;
  }

  String parseEvent() {
    String event = _parse('EV', (match) => match);
    return event;
  }

  Game parse() {
    var attributes = _parseAttributes();
    var moves = _parseMoves();

    return Game(attributes, moves);
  }

  SGFParser(this.sgf);
}