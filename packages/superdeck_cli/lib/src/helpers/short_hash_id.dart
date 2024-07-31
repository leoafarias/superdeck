/// Generates a short, unique identifier from a given string.
/// This is needed as hashCode for strings is not guaranteed to be unique across different platforms
///
/// This function uses a hashing mechanism to transform the input string into
/// a unique, 8-character identifier. It is useful for creating compact and
/// unique keys for database entries, URLs, etc.
///
/// [valueToHash] is the string input that you want to convert into a hash ID.
///
/// Returns an 8-character string that represents the hashed ID.
String shortHashId(String valueToHash) {
  // Define a string of possible characters that can appear in the output hash.
  const characters =
      'aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ0123456789';

  // Initialize hash to zero.
  int hash = 0;

  // Calculate the hash value from each character in the input string.
  for (int i = 0; i < valueToHash.length; i++) {
    int charIndex = characters.indexOf(valueToHash[i]);
    // Continue to next iteration if character is not found in the characters string.
    if (charIndex == -1) {
      continue;
    }
    // Update the hash value using the character's index and position.
    hash = (hash * 31 + charIndex + i) % 2147483647;
  }

  // Initialize the short ID as an empty string.
  String shortId = '';
  int base = characters.length;
  int remainingHash = hash;

  // Construct the short ID using the hash value.
  for (int i = 0; i < 8; i++) {
    shortId += characters[remainingHash % base];
    remainingHash = (remainingHash * 31 + hash) % 2147483647;
  }

  return shortId;
}
