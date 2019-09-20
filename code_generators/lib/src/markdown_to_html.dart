import 'package:build/build.dart';
import 'package:markdown/markdown.dart';

class MarkdownToHtmlBuilder extends Builder {
  MarkdownToHtmlBuilder(this.options);

  final BuilderOptions options;

  @override
  Map<String, List<String>> get buildExtensions => {
        '.md': ['.html']
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    print(options.config);
    var config = options.config;

    // Grab the object matching our input file
    var inputId = buildStep.inputId;

    // Create a new target `AssetId`
    var copy = inputId.changeExtension('.html');
    var contents = await buildStep.readAsString(inputId);

    // Write out the new asset
    await buildStep.writeAsString(copy, '''
<html>
  <head>
    <title>${config['pageTitle']}</title>
    <meta name="author" content="${config['author']}" />
  </head>
  <body>
      ${markdownToHtml(contents)}
  </body>
</html>
    ''');
  }
}
