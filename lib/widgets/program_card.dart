import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProgramCard extends StatelessWidget {
  final String title;
  final String instructor;
  final String students;
  final String? imageUrl;
  final double rating;
  final VoidCallback onTap;

  const ProgramCard({
    super.key,
    required this.title,
    required this.instructor,
    required this.students,
    this.imageUrl,
    this.rating = 0.0,
    required this.onTap,
  });

  Widget _buildGradientPlaceholder() {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(108, 92, 231, 0.8),
            Color.fromRGBO(108, 92, 231, 0.4),
          ],
        ),
      ),
      child: const Center(
        child: Icon(Icons.code, color: Colors.white, size: 32),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      height: 90,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildGradientPlaceholder(),
                      errorWidget: (context, url, error) => _buildGradientPlaceholder(),
                    )
                  : _buildGradientPlaceholder(),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$instructor • $students students',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      fontSize: 12,
                    ),
                  ),
                  if (rating > 0) ...[
                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      const SizedBox(width: 6),
                      Text(rating.toStringAsFixed(1)),
                    ]),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}