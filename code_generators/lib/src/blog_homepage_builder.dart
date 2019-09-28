import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;

class BlogHomepageBuilder extends Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        r'$web$': ['index.html']
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final files = <String>[];

    await for (var input in buildStep.findAssets(Glob('*.md'))) {
      // print('${input.pathSegments}, ${input.uri}');
      var contents = await buildStep.readAsString(input);
      var name = contents.split('\n')[0].replaceAll('# ', '');

      // Create links to converted markdown files
      var fileName = input.pathSegments.last.replaceAll('.md', '');
      files.add('<li><a href="${fileName}.html">${name}</a></li>');
    }

    var output =
        AssetId(buildStep.inputId.package, p.join('web', 'index.html'));

    await buildStep.writeAsString(output, '''
<html>
<body>
  <h1>Latest Blog posts</h1>
  <ul>
    ${files.join('\n')}
  </ul>
</body>
</html>
''');
  }
}
