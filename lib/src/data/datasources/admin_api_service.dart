import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stirred_common_domain/src/config.dart';
import 'package:stirred_common_domain/src/domain/models/auth/signup_response.dart';
import 'package:stirred_common_domain/src/domain/models/login_response.dart';

part 'admin_api_service.g.dart';


@RestApi(baseUrl: baseStirredAdminUrl, parser: Parser.MapSerializable)
abstract class AdminApiService {
  factory AdminApiService(Dio dio, {String baseUrl}) = _AdminApiService;

  @POST('/auth/signup/')
  Future<HttpResponse<SignupResponse>> signup(@Body() Map<String, String> body);

  @POST('/auth/token/login/')
  Future<HttpResponse<LoginResponse>> getTokens(@Body() Map<String, dynamic> credentials);

  @POST('/auth/token/verify/')
  Future<HttpResponse<void>> verifyToken(@Body() Map<String, dynamic> token);

  @POST('/auth/token/refresh/')
  Future<HttpResponse<LoginResponse>> refreshToken(@Body() Map<String, dynamic> token);

  @POST('/auth/check-username/')
  Future<HttpResponse<dynamic>> checkUsernameValidity(@Body() Map<String, dynamic> body);

}
