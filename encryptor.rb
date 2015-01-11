class Encryptor
  def cipher(rotation)
    # 1. Create an array of characters from the range ‘a’ to ‘z’.
    characters = (' '..'z').to_a
    # 2. Create a second array that is a list of characters rotated by the amount to rotate.
    rotated_characters = characters.rotate(rotation)
    # 3. Create a Hash with the first list as the keys and the second list as the values.
    # Using an array method called zip.  Zip works like a clothing zipper by merging the two lists together like the teeth of a zipper. One after the other.
    Hash[characters.zip(rotated_characters)]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def encrypt(string, rotation)
    # 1. Cut the input string into letters
    letters = string.split("")
    # 2. Encrypt those letters one at a time, gathering the results
    encrypted = letters.collect do |letter|
      encrypted_letter = encrypt_letter(letter,rotation)
    end
    # 3. Join the results back together in one string
    encrypted.join
  end

  def decrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation).invert
    cipher_for_rotation[letter]
  end

  def decrypt(string, rotation)
    letters = string.split("")
    decrypted = letters.collect do |letter|
      decrypted_letter = decrypt_letter(letter,rotation)
    end
    decrypted.join
  end

  def encrypt_file(filename, rotation)
    # 1. Create the file handle to the input file
    input = File.open(filename, "r")
    # 2. Read the text of the input file
    file_contents = input.read
    # 3. Encrypt the text
    encrypted_contents = encrypt(file_contents, rotation)
    # 4. Create a name for the output file
    encrypted_file = filename + ".encrypted"
    # 5. Create an output file handle
    output = File.open(encrypted_file, "w")
    # 6. Write out the text
    output.write(encrypted_contents)
    # 7. Close the file
    output.close
  end

  def decrypt_file(filename, rotation)
    # 1. Create the file handle to the encrypted file
    input = File.open(filename, "r")
    # 2. Read the encrypted text
    file_contents = input.read
    # 3. Decrypt the text by passing in the text and rotation
    decrypted_contents = decrypt(file_contents, rotation)
    # 4. Create a name for the decrypted file
    decrypted_file = filename.gsub("encrypted", "decrypted")
    # 5. Create an output file handle
    output = File.open(decrypted_file, "w")
    # 6. Write out the text
    output.write(decrypted_contents)
    # 7. Close the file
    output.close
  end

  def supported_characters
    (' '..'z').to_a
  end

  def crack(message)
    supported_characters.count.times.collect do |attempt|
      decrypt(message,attempt)
    end
  end
end
