import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

const String localUrl = "https://127.0.0.1:8000/";

const String baseUrl = localUrl;

const String baseStirredAdminUrl = baseUrl;
const String baseStirredApiUrl = "${baseUrl}api/";
const String baseMediaUrl = "${baseUrl}media/";

const storage = FlutterSecureStorage();
final logger = Logger();