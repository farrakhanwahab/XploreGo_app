import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showFavoriteMessage(BuildContext context, String countryName, bool wasAdded) {
    final message = wasAdded 
        ? '$countryName added to favorites' 
        : '$countryName removed from favorites';
    
    final icon = wasAdded ? Icons.favorite : Icons.favorite_border;
    final backgroundColor = wasAdded ? Colors.green : Colors.orange;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
} 