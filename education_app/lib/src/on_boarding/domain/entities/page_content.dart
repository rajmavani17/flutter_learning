import 'package:education_app/core/res/media_res.dart';
import 'package:equatable/equatable.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  const PageContent.first()
      : this(
          image: MediaRes.casualReading,
          title: 'Brand new Curriculum',
          description: 'We have a brand new curriculum that will '
              'help you learn and understand better.',
        );

  const PageContent.second()
      : this(
          image: MediaRes.casualLife,
          title: 'Brand a fun atmosphere ',
          description: 'We have a brand new Atmosphere that will '
              'help you learn and understand better.',
        );

  const PageContent.third()
      : this(
          image: MediaRes.casualMeditation,
          title: 'Brand a fun atmosphere ',
          description: 'We have a brand new Atmosphere that will '
              'help you learn and understand better.',
        );
  final String image;
  final String title;
  final String description;

  @override
  List<Object> get props => [image, title, description];
}
