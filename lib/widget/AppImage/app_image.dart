import 'dart:io';
import 'package:flutter/material.dart';
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
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  Widget _buildImage() {
    if (filePath != null) {
      return Image.file(
        File(filePath!),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }

    if (url != null) {
      if (url!.toLowerCase().contains("null")) return _buildPlaceholder();
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
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }

    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey.shade100,
      child: const Center(
        child: Icon(Icons.image_not_supported_outlined, size: 48, color: Colors.grey),
      ),
    );
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
    return Image.network(
      _resolvedUrl,
      width: width,
      height: height,
      fit: fit,
      // Flutter built-in memory cache — no package needed
      cacheWidth: (width != null && width!.isFinite) ? width!.toInt() : null,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          color: Colors.grey.shade100,
          child: const Center(
            child: AppLoader(),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => Container(
        width: width,
        height: height,
        color: Colors.grey.shade100,
        child: const Center(
          child: Icon(Icons.image_not_supported_outlined, size: 48, color: Colors.grey),
        ),
      ),
    );
  }
}

class CustomHttpClient extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}