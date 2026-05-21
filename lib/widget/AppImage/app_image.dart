import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/app_api_url.dart';
import '../AppLoader/app_loader.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.color = Colors.grey,
    this.fit = BoxFit.fill,
    this.height,
    this.path,
    this.url,
    this.width,
    this.filePath,
    this.iconColor,
  });

  final String? path;
  final String? filePath;
  final String? url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Color color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _buildImage(),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  Widget _buildImage() {
    if (filePath != null) {
      return Image.file(
        File(filePath!),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) =>
            _PlaceholderWidget(width: width, height: height),
      );
    }

    if (url != null) {
      if (url!.isEmpty || url!.toLowerCase().contains("null")) {
        return _PlaceholderWidget(width: width, height: height);
      }
      return _NetworkImage(
        imageUrl: url!,
        width: width,
        height: height,
        fit: fit,
      );
    }

    if (path != null) {
      return Image.asset(
        path!,
        width: width,
        height: height,
        fit: fit,
        color: iconColor,
        errorBuilder: (_, _, _) =>
            _PlaceholderWidget(width: width, height: height),
      );
    }

    return _PlaceholderWidget(width: width, height: height);
  }
}

class _NetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const _NetworkImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  String get _resolvedUrl {
    final uri = Uri.tryParse(imageUrl);
    if (uri != null && (uri.isScheme('http') || uri.isScheme('https'))) {
      return imageUrl;
    }
    return "${AppApiUrl.domain}$imageUrl";
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: _resolvedUrl,
      width: width,
      height: height,
      fit: fit,
      cacheKey: _resolvedUrl,
      placeholder: (_, _) => _LoadingWidget(width: width, height: height),
      errorWidget: (_, _, _) => _PlaceholderWidget(width: width, height: height),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const _LoadingWidget({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade100,
      child: Center(child: AppLoader(size: 30.sp)),
    );
  }
}

class _PlaceholderWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const _PlaceholderWidget({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade100,
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 48,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class CustomHttpClient extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
