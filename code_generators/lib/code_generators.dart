library code_generators;

import 'package:build/build.dart';
import 'package:code_generators/src/copy_builder.dart';
import 'package:code_generators/src/markdown_to_html.dart';

Builder copyBuilder(BuilderOptions options) => CopyBuilder();

Builder markdownToHtmlBuilder(BuilderOptions options) =>
    MarkdownToHtmlBuilder(options);
