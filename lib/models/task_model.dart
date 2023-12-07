import 'dart:convert';

class TaskModel {
  int id;
  String name;
  String status;
  String userId;
  String teamId;
  DateTime createdAt;
  DateTime updatedAt;
  Team team;

  TaskModel({
    required this.id,
    required this.name,
    required this.status,
    required this.userId,
    required this.teamId,
    required this.createdAt,
    required this.updatedAt,
    required this.team,
  });

  factory TaskModel.fromRawJson(String str) =>
      TaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        userId: json["user_id"],
        teamId: json["team_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        team: Team.fromJson(json["team"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "user_id": userId,
        "team_id": teamId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "team": team.toJson(),
      };
}

class Team {
  int id;
  String name;
  String code;
  DateTime createdAt;
  DateTime updatedAt;

  Team({
    required this.id,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Team.fromRawJson(String str) => Team.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
