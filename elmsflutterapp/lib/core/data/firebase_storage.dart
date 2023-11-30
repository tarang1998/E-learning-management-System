import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class FirebaseStorageWrapper {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final String _storageBucket = "gs://elms-88a47.appspot.com/";

  String get storageBucket =>
      _storageBucket.substring(5, _storageBucket.length - 1);

  String getStoragePath() => _storageBucket;

  Future<String> getDownloadableURL(String path) async {
    Reference _storageReference = _storage.refFromURL(path);
    return await _storageReference.getDownloadURL();
  }

  Future<void> uploadFileToStorageBucket({
    required PlatformFile file,
    required String path,
  }) async {
    Reference _storageReference = _storage.refFromURL(path);
    await _storageReference.putData(file.bytes!);
    return;
  }

  Future<String> deleteFileFromStorageBucket({required String path}) async {
    Reference ref = _storage.refFromURL(path);
    final String fullPath = ref.fullPath;
    final String uri = fullPath.replaceAll(_storageBucket, '');
    await ref.delete();

    return uri;
  }

  String getMediaUriFromUrl(String path) {
    Reference ref = _storage.refFromURL(path);
    final String fullPath = ref.fullPath;
    final String uri = fullPath.replaceAll(_storageBucket, '');

    return uri;
  }
}
