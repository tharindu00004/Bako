class VideoItem {
  final String id;
  final String title;
  final String subtitle;
  final String duration;
  final String views;

  VideoItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.views,
  });

  static VideoItem getSampleFeatured() {
    return VideoItem(
      id: 'v1',
      title: 'කමල් පෙරේරා',
      subtitle: 'JCB 3DX - වැඩ කරන ආකාරය',
      duration: '02:36',
      views: '1.8k',
    );
  }
}
