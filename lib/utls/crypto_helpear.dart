import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypt_handle;
import 'package:encrypt/encrypt.dart';

class CryptoHelper {
  //instead of plain text convert key,iv to base64 and use .fromBase64 for better security

  Future<void> encrypt(
      {required String inputPath,
        required String outputPath,
        required String key,
        required String ivw}) async {
/*    final encryptionKey = encrypt_handle.Key.fromUtf8(key);
    final encryptionIv = encrypt_handle.IV.fromUtf8(iv);
    final encrypter = encrypt_handle.Encrypter(
        encrypt_handle.AES(encryptionKey, mode: encrypt_handle.AESMode.ctr));*/

    File inputFile = File(inputPath);
    File outputFile = File(outputPath);

    bool outputFileExists = await outputFile.exists();
    bool inputFileExists = await inputFile.exists();
    final videoFileContents = await inputFile.readAsStringSync(encoding: latin1);

    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromUtf8(ivw);

    final encrypter = Encrypter(AES(key));
print("startEdnc");
    final encrypted = encrypter.encrypt(videoFileContents, iv: iv);
    print("done");

    await outputFile.writeAsBytes(encrypted.bytes);
    await inputFile.delete();
  }

  Future<void> decrypt(
      {required String inputPath,
        required String outputPath,
        required String key,
        required String ivw}) async {
    print("start");
    /*final encryptionKey = encrypt_handle.Key.fromUtf8(key);
    final encryptionIv = encrypt_handle.IV.fromUtf8(iv);*/
   /* final encrypter = encrypt_handle.Encrypter(
        encrypt_handle.AES(encryptionKey, mode: encrypt_handle.AESMode.cbc));*/

    File inputFile = File(inputPath);
    File outputFile = File(outputPath);

    bool outputFileExists = await outputFile.exists();
    bool inputFileExists = await inputFile.exists();

    final videoFileContents = await inputFile.readAsBytesSync();

    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromUtf8(ivw);

    if(!outputFileExists){
      await outputFile.create();
    }
    final encrypterw = Encrypter(AES(key));

    final encryptedFile = Encrypted(videoFileContents);
    final decrypted = encrypterw.decrypt(encryptedFile, iv: iv);

    final decryptedBytes = latin1.encode(decrypted);
    print("done decr");
    await outputFile.writeAsBytes(decryptedBytes);

  }
}