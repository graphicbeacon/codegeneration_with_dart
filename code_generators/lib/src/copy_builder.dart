import 'package:build/build.dart';

class CopyBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        '.txt': ['.copy.txt']
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    // Retrieve the currently matched asset
    AssetId inputId = buildStep.inputId;

    // Create a new target `AssetId` based on the current one
    var copyAssetId = inputId.changeExtension('.copy.txt');
    var contents = await buildStep.readAsString(inputId);

    // Write out the new asset
    await buildStep.writeAsString(copyAssetId, '''
---
${DateTime.now()}
---
$contents
''');
  }
}
