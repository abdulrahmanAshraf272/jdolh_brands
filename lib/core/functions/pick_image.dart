import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

Future<void> pickImageFromGallery() async {
  final ImagePicker _picker = ImagePicker();
  XFile? xfile;

  try {
    xfile = await _picker.pickImage(source: ImageSource.gallery);
  } catch (e) {
    print("Error picking image: $e");
    return;
  }

  if (xfile == null) {
    // User canceled image picking
    return;
  }

  // Validate the file extension
  String extension = getExtension(xfile.path);

  if (isValidImageExtension(extension)) {
    // Handle the valid image
    print("Selected image path: ${xfile.path}");
  } else {
    // Handle invalid image extension (e.g., it's not a common image file)
    print("Invalid image extension: $extension");
  }
}

Future<void> pickImageFromCamera() async {
  final ImagePicker _picker = ImagePicker();
  XFile? xfile;

  try {
    xfile = await _picker.pickImage(source: ImageSource.camera);
  } catch (e) {
    print("Error picking image: $e");
    return;
  }

  if (xfile == null) {
    // User canceled image picking
    return;
  }

  // Validate the file extension
  String extension = getExtension(xfile.path);

  if (isValidImageExtension(extension)) {
    // Handle the valid image
    print("Selected image path: ${xfile.path}");
  } else {
    // Handle invalid image extension (e.g., it's not a common image file)
    print("Invalid image extension: $extension");
  }
}

bool isValidImageExtension(String extension) {
  // List of common image extensions
  List<String> validExtensions = ['jpg', 'jpeg', 'png'];

  // Check if the extension is in the valid extensions list
  return validExtensions.contains(extension.toLowerCase());
}

String getExtension(String filename) {
  // Split the filename based on "."
  List<String> parts = filename.split('.');

  // Check if there's at least one dot (meaning there might be an extension)
  if (parts.length > 1) {
    // Return the last part, which is the extension
    return parts.last;
  } else {
    // No extension found, return an empty string
    return '';
  }
}
