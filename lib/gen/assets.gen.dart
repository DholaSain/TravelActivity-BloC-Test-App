/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Cristofer.jpeg
  AssetGenImage get cristofer =>
      const AssetGenImage('assets/images/Cristofer.jpeg');

  /// File path: assets/images/Lousiana.jpg
  AssetGenImage get lousiana =>
      const AssetGenImage('assets/images/Lousiana.jpg');

  /// File path: assets/images/Tommy.jpeg
  AssetGenImage get tommy => const AssetGenImage('assets/images/Tommy.jpeg');

  /// File path: assets/images/group.png
  AssetGenImage get group => const AssetGenImage('assets/images/group.png');

  /// List of all assets
  List<AssetGenImage> get values => [cristofer, lousiana, tommy, group];
}

class $AssetsVectorsGen {
  const $AssetsVectorsGen();

  /// File path: assets/vectors/bg-brand-bar-z.svg
  String get bgBrandBarZ => 'assets/vectors/bg-brand-bar-z.svg';

  /// File path: assets/vectors/brand-bar.svg
  String get brandBar => 'assets/vectors/brand-bar.svg';

  /// File path: assets/vectors/camera.svg
  String get camera => 'assets/vectors/camera.svg';

  /// File path: assets/vectors/drop-box.svg
  String get dropBox => 'assets/vectors/drop-box.svg';

  /// File path: assets/vectors/flag.svg
  String get flag => 'assets/vectors/flag.svg';

  /// File path: assets/vectors/heading-left.svg
  String get headingLeft => 'assets/vectors/heading-left.svg';

  /// File path: assets/vectors/more-hrz.svg
  String get moreHrz => 'assets/vectors/more-hrz.svg';

  /// List of all assets
  List<String> get values => [
    bgBrandBarZ,
    brandBar,
    camera,
    dropBox,
    flag,
    headingLeft,
    moreHrz,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsVectorsGen vectors = $AssetsVectorsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
