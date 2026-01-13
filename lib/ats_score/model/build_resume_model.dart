import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Welcome {
    @JsonKey(name: "summary")
    final String? summary;
    @JsonKey(name: "education")
    final List<Education>? education;
    @JsonKey(name: "experience")
    final List<Experience>? experience;
    @JsonKey(name: "projects")
    final List<Project>? projects;
    @JsonKey(name: "skills")
    final List<String>? skills;
    @JsonKey(name: "achievement")
    final List<dynamic>? achievement;

    Welcome({
        this.summary,
        this.education,
        this.experience,
        this.projects,
        this.skills,
        this.achievement,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => _$WelcomeFromJson(json);

    Map<String, dynamic> toJson() => _$WelcomeToJson(this);
}

@JsonSerializable()
class Education {
    @JsonKey(name: "institution")
    final String? institution;
    @JsonKey(name: "degree")
    final String? degree;
    @JsonKey(name: "domain")
    final String? domain;
    @JsonKey(name: "from")
    final String? from;
    @JsonKey(name: "to")
    final String? to;
    @JsonKey(name: "cgpa")
    final String? cgpa;

    Education({
        this.institution,
        this.degree,
        this.domain,
        this.from,
        this.to,
        this.cgpa,
    });

    factory Education.fromJson(Map<String, dynamic> json) => _$EducationFromJson(json);

    Map<String, dynamic> toJson() => _$EducationToJson(this);
}

@JsonSerializable()
class Experience {
    @JsonKey(name: "company")
    final String? company;
    @JsonKey(name: "role")
    final String? role;
    @JsonKey(name: "from")
    final String? from;
    @JsonKey(name: "to")
    final String? to;
    @JsonKey(name: "topic")
    final String? topic;
    @JsonKey(name: "bullets")
    final List<String>? bullets;

    Experience({
        this.company,
        this.role,
        this.from,
        this.to,
        this.topic,
        this.bullets,
    });

    factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);

    Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}

@JsonSerializable()
class Project {
    @JsonKey(name: "name")
    final String? name;
    @JsonKey(name: "description")
    final List<String>? description;
    @JsonKey(name: "tools")
    final List<String>? tools;

    Project({
        this.name,
        this.description,
        this.tools,
    });

    factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

    Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
