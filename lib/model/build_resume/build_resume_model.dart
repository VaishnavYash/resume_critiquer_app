import 'package:json_annotation/json_annotation.dart';

part 'build_resume_model.g.dart';

@JsonSerializable()
class BuildResumeModelResponse {
  String? status;
  BuildResumeContent? content;

  BuildResumeModelResponse({this.status, this.content});

  factory BuildResumeModelResponse.fromJson(Map<String, dynamic> json) =>
      _$BuildResumeModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BuildResumeModelResponseToJson(this);
}

@JsonSerializable()
class BuildResumeContent {
  PersonalInfo? personal;
  String? summary;
  List<Education>? education;
  List<Experience>? experience;
  List<Project>? projects;
  Map<String, List<String>>? skills;
  List<String>? achievement;

  BuildResumeContent({
    this.personal,
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
  String? institution;
  String? degree;
  String? domain;
  String? from;
  String? to;
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
  String? company;
  String? role;
  String? from;
  String? to;
  String? topic;
  List<String>? bullets;
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
  String? name;
  List<String>? description;
  List<String>? tools;
  String? location;
  String? url;
  String? from;
  String? to;

  Project({
    this.name,
    this.description,
    this.tools,
    this.location,
    this.url,
    this.from,
    this.to,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}

@JsonSerializable()
class PersonalInfo {
  String? name;
  String? email;
  String? phone;
  List<String>? urls;
  String? location;
  String? designation;

  PersonalInfo({
    this.name,
    this.email,
    this.phone,
    this.urls,
    this.location,
    this.designation,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalInfoToJson(this);
}
