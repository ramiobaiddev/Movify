import 'package:movify/core/utils/enums/content_type.dart';

/// Which suggestion list a title offers.
enum RelatedList {
  recommended('Recommended'),
  similar('Similar');

  const RelatedList(this.title);

  final String title;
}

/// Everything the Recommended / Similar screen needs to load its list.
class RelatedArgs {
  const RelatedArgs({required this.kind, required this.id, required this.list});

  final ContentType kind;
  final int id;
  final RelatedList list;
}
