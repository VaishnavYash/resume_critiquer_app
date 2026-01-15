// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'build_resume_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildResumeModelResponse _$BuildResumeModelResponseFromJson(
  Map<String, dynamic> json,
) => BuildResumeModelResponse(
  status: json['status'] as String?,
  content:
      json['content'] == null
          ? null
          : BuildResumeContent.fromJson(
            json['content'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$BuildResumeModelResponseToJson(
  BuildResumeModelResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'content': instance.content?.toJson(),
};

BuildResumeContent _$BuildResumeContentFromJson(Map<String, dynamic> json) =>
    BuildResumeContent(
      summary: json['summary'] as String?,
      education:
          (json['education'] as List<dynamic>?)
              ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
              .toList(),
      experience:
          (json['experience'] as List<dynamic>?)
              ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
              .toList(),
      projects:
          (json['projects'] as List<dynamic>?)
              ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
              .toList(),
      skills:
          json['skills'] == null
              ? null
              : Skills.fromJson(json['skills'] as Map<String, dynamic>),
      achievement:
          (json['achievement'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$BuildResumeContentToJson(BuildResumeContent instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'education': instance.education?.map((e) => e.toJson()).toList(),
      'experience': instance.experience?.map((e) => e.toJson()).toList(),
      'projects': instance.projects?.map((e) => e.toJson()).toList(),
      'skills': instance.skills?.toJson(),
      'achievement': instance.achievement,
    };

Education _$EducationFromJson(Map<String, dynamic> json) => Education(
  institution: json['institution'] as String?,
  degree: json['degree'] as String?,
  domain: json['domain'] as String?,
  from: json['from'] as String?,
  to: json['to'] as String?,
  cgpa: json['cgpa'] as String?,
);

Map<String, dynamic> _$EducationToJson(Education instance) => <String, dynamic>{
  'institution': instance.institution,
  'degree': instance.degree,
  'domain': instance.domain,
  'from': instance.from,
  'to': instance.to,
  'cgpa': instance.cgpa,
};

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
  company: json['company'] as String?,
  role: json['role'] as String?,
  from: json['from'] as String?,
  to: json['to'] as String?,
  topic: json['topic'] as String?,
  bullets:
      (json['bullets'] as List<dynamic>?)?.map((e) => e as String).toList(),
  location: json['location'] as String?,
);

Map<String, dynamic> _$ExperienceToJson(Experience instance) =>
    <String, dynamic>{
      'company': instance.company,
      'role': instance.role,
      'from': instance.from,
      'to': instance.to,
      'topic': instance.topic,
      'bullets': instance.bullets,
      'location': instance.location,
    };

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
  name: json['name'] as String?,
  description:
      (json['description'] as List<dynamic>?)?.map((e) => e as String).toList(),
  tools: (json['tools'] as List<dynamic>?)?.map((e) => e as String).toList(),
  location: json['location'] as String?,
);

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'tools': instance.tools,
  'location': instance.location,
};

Skills _$SkillsFromJson(Map<String, dynamic> json) => Skills(
  technicalSkills:
      (json['technical_skills'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  databases:
      (json['databases'] as List<dynamic>?)?.map((e) => e as String).toList(),
  toolsTechnologies:
      (json['tools_technologies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
);

Map<String, dynamic> _$SkillsToJson(Skills instance) => <String, dynamic>{
  'technical_skills': instance.technicalSkills,
  'tools_technologies': instance.toolsTechnologies,
  'databases': instance.databases,
};
