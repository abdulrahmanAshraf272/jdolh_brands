import 'dart:math';

// Function to generate a random password
String generatePassword({int length = 10}) {
  // Define characters that can be used in the password
  String characters = 'abcdefghijklmnopqrstuvwxyzABFGHJKPTUYZ0123456789@#%&';

  // Get the total number of characters
  int charLength = characters.length;

  // Initialize the password variable
  String password = '';

  // Generate random password
  for (int i = 0; i < length; i++) {
    int randomIndex = Random().nextInt(charLength);
    password += characters[randomIndex];
  }

  return password;
}

// Function to generate a username

String generateUsername(String fullName) {
  // Extract the first name
  List<String> names = fullName.split(' ');
  String firstName = names[0];

  // Generate 4 random numbers
  int randomNumbers = Random().nextInt(9000) + 1000;

  // Concatenate the first name with random numbers
  String username = '$firstName$randomNumbers';
  return username;
}

void main() {
  // Example usage of the generatePassword function
  String password = generatePassword(length: 12);
  print("Generated Password: $password");

  // Example usage of the generateUsername function
  String username = generateUsername("John Doe");
  print("Generated Username: $username");
}
