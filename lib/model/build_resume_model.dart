import 'package:json_annotation/json_annotation.dart';

part 'build_resume_model.g.dart';

@JsonSerializable()
class BuildResumeModelResponse {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'content')
  BuildResumeContent? content;

  BuildResumeModelResponse({this.status, this.content});

  factory BuildResumeModelResponse.fromJson(Map<String, dynamic> json) =>
      _$BuildResumeModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BuildResumeModelResponseToJson(this);
}

@JsonSerializable()
class BuildResumeContent {
  @JsonKey(name: "summary")
  String? summary;
  @JsonKey(name: "education")
  List<Education>? education;
  @JsonKey(name: "experience")
  List<Experience>? experience;
  @JsonKey(name: "projects")
  List<Project>? projects;
  @JsonKey(name: "skills")
  Map<String, List<String>>? skills;
  @JsonKey(name: "achievement")
  List<String>? achievement;

  BuildResumeContent({
    this.summary,
    this.education,
    this.experience,
    this.projects,
    this.skills,
    this.achievement,
  });

  factory BuildResumeContent.fromJson(Map<String, dynamic> json) =>
      _$BuildResumeContentFromJson(json);

  Map<String, dynamic> toJson() => _$BuildResumeContentToJson(this);
}

@JsonSerializable()
class Education {
  @JsonKey(name: "institution")
  String? institution;
  @JsonKey(name: "degree")
  String? degree;
  @JsonKey(name: "domain")
  String? domain;
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "to")
  String? to;
  @JsonKey(name: "cgpa")
  String? cgpa;

  Education({
    this.institution,
    this.degree,
    this.domain,
    this.from,
    this.to,
    this.cgpa,
  });

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);

  Map<String, dynamic> toJson() => _$EducationToJson(this);
}

@JsonSerializable()
class Experience {
  @JsonKey(name: "company")
  String? company;
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: "from")
  String? from;
  @JsonKey(name: "to")
  String? to;
  @JsonKey(name: "topic")
  String? topic;
  @JsonKey(name: "bullets")
  List<String>? bullets;
  @JsonKey(name: "location")
  String? location;

  Experience({
    this.company,
    this.role,
    this.from,
    this.to,
    this.topic,
    this.bullets,
    this.location,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}

@JsonSerializable()
class Project {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  List<String>? description;
  @JsonKey(name: "tools")
  List<String>? tools;
  @JsonKey(name: "location")
  String? location;

  Project({this.name, this.description, this.tools, this.location});

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
