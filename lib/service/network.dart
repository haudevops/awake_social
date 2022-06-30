// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
//
// class MutualCheckWFTAPI {
//   factory MutualCheckWFTAPI() {
//     return _instance;
//   }
//
//   MutualCheckWFTAPI._internal() {
//     final options = BaseOptions(
//       baseUrl: mutualCheckWFT,
//       connectTimeout: 30000,
//       receiveTimeout: 30000,
//       headers: {},
//       contentType: 'application/json',
//       responseType: ResponseType.json,
//     );
//
//     dio = Dio(options);
//
//     dio.interceptors.add(InterceptorsWrapper(onRequest: (options) async {
//       final token = await SPref.instance.get(SPrefCache.KEY_ACCESS_TOKEN);
//       // const token = '90800p6c5121c94b12cc751cac1944d040b102a5';
//       if (token != null) {
//         options.headers['content-type'] = 'application/json';
//         options.headers['Authorization'] = 'Bearer $token';
//         print(token);
//       }
//       return options;
//     }));
//
//     dio.interceptors.add(LoggerInterceptor());
//   }
//
//   static final MutualCheckWFTAPI _instance = MutualCheckWFTAPI._internal();
//   static const String TAG = 'DIO';
//   Dio dio;
//
//   Future get<T>(String path,
//       {Map<String, dynamic> params, Options options}) async {
//     try {
//       final response =
//       await dio.get(path, queryParameters: params, options: options);
//       return handleResponse<T>(response);
//     } on DioError catch (e) {
//       return BaseResponse(
//           false, createErrorEntity(e).code, createErrorEntity(e).message, null);
//     }
//   }
//
//   Future post<T>(String path,
//       {Map<String, dynamic> params, Options options}) async {
//     try {
//       final response = await dio.post(path, data: params, options: options);
//       return handleResponse<T>(response);
//     } on DioError catch (e) {
//       return BaseResponse(
//           false, createErrorEntity(e).code, createErrorEntity(e).message, null);
//     }
//   }
//
//   Future put<T>(String path, {Map<String, dynamic> params}) async {
//     try {
//       final response = await dio.put(path, data: params);
//       return handleResponse<T>(response);
//     } on DioError catch (e) {
//       return BaseResponse(
//           false, createErrorEntity(e).code, createErrorEntity(e).message, null);
//     }
//   }
//
//   BaseResponse<T> handleResponse<T>(Response response) {
//     // print('Response API $response');
//     const _statusKey = 'Status';
//     const _dataKey = 'Data';
//     const _msgKey = 'ErrorMessages';
//
//     bool _status;
//     int _code;
//     T _data;
//     List<String> _msg;
//
//     if (response.statusCode == HttpStatus.ok ||
//         response.statusCode == HttpStatus.created) {
//       try {
//         if (response.data is Map) {
//           _status = response.data[_statusKey];
//           _data = _status ? response.data[_dataKey] : null;
//           _msg = !_status ? List<String>.from(response.data[_msgKey]) : null;
//         } else {
//           final _dataMap = _decodeData(response);
//           _status = response.data[_statusKey];
//           _data = _status ? _dataMap[_dataKey] : null;
//           _msg = !_status ? _dataMap[_msgKey] : null;
//         }
//         if (!_status) {
//           return BaseResponse(_status, _code, defineMsg(_msg[0]), _data);
//         }
//         return BaseResponse(_status, _code, Constants.SUCCESS, _data);
//       } catch (e) {
//         log('$TAG ${e.toString()}');
//         return null;
//       }
//     }
//   }
//
//   Map<String, dynamic> _decodeData(Response response) {
//     if (response == null ||
//         response.data == null ||
//         response.data.toString().isEmpty) {
//       return {};
//     }
//     return json.decode(response.data.toString());
//   }
//
//   String defineMsg(String msgCode) {
//     final msg = <String, String>{
//       'ErrFullScan': 'Đã nhập đủ hàng',
//       'ErrCodeExists': 'Kiện hàng đã nhập',
//       'ErrStorageType': 'Mã kiện hàng không tồn tại',
//       'ErrFullPicked': 'Đã lấy đủ hàng',
//       'ErrFullPickedInBin': 'Đã lấy đủ hàng trong Bin',
//       'ErrPackageNotFound': 'Mã kiện hàng không tồn tại',
//       'ErrPicked': 'Kiện hàng đã lấy',
//       'ErrNotFoundInBin': 'Không tìm thấy kiện hàng trong Bin',
//       'ErrSONotFound': 'Không tìm thấy mã Kiện',
//       'ErrTypeScanIsPackage': 'Phải scan bằng mã kiện',
//       'ErrTypeScanIsSO': 'Kiện hàng phải scan bằng mã SO',
//       'ErrSO3PLNotFound': 'Không tìm thấy thông tin SO',
//       'ErrInvalidBinCode': 'Nhập không đúng Bin',
//       'ErrNotAssign': 'Bạn không có quyền xuất hàng kiện này.',
//       'ErrPackageNotAssign': 'Bạn chưa được ủy quyền để lấy hàng.',
//       'ErrNotFound': 'Không tìm thấy mã',
//       'ErrBinNotFound': 'Không tìm thấy Bin',
//       'ET001': 'Pallet không tìm thấy',
//       'ET002': 'Pallet chưa định vị',
//       'ET003': 'Pallet đã chứa hàng',
//       'ET004': 'Không tạo được Pallet',
//       'ET005': 'Pallet không chứa hàng',
//       'ET006': 'Pallet đang chứa SKU xuất hàng',
//       'EB001': 'Bin/Point không tìm thấy',
//       'EB002': 'Bin không thuộc lưu trữ',
//       'EB003': 'Bin full',
//       'EB004': 'Bin đang nhận hàng',
//       'EB005': 'Không tìm thấy phiên để nhập hàng',
//       'EB006': 'Hàng trong Pallet đã nhập',
//       'EB007': 'Bin không tìm thấy hoặc trạng thái Bin không hợp lệ',
//       'EB008': 'Point không tìm thấy hoặc trạng thái Point không hợp lệ',
//       'EB009':
//       'Bin/Point không tìm thấy hoặc trạng thái Bin/Point không hợp lệ',
//       'EB010': 'Pallet không thuộc Bin/Point yêu cầu',
//       'EB011': 'Vị trí lưu trữ đã đủ số lượng Pallet',
//       'EB012': 'Vị trí lưu trữ đã đủ số lượng sản phẩm',
//       'EB013': 'Vị trí lưu trữ chỉ chứa hàng lẻ. Vui lòng kiểm tra lại!',
//       'EPO001': 'Không tìm thấy PO',
//       'EPO002': 'PO đã huỷ',
//       'EPO003': 'PO đang xử lý',
//       'EPO004': 'PO đã hoàn thành.',
//       'EPO005': 'Không tìm thấy phiên',
//       'EPO006':
//       'Số lượng nhập lớn hơn số lượng chờ xử lý. Vui lòng kiểm tra lại!',
//       'EPO007': 'Không tìm thấy phiên để kết thúc',
//       'EPO008': 'PO đã được xử lý bởi thành viên khác. vui lòng kiểm tra lại!',
//       'EPO009': 'Mã Pallet không đúng',
//       'EPO010': 'PO đã nhận hàng thành công',
//       'EPO011': 'Không scan được Barcode || Nhập Barcode',
//       'EPO012': 'Không thể kết thúc nhận hàng Pallet. Vui lòng kiểm tra lại!',
//       'EPO013': 'Đơn hàng đã nhận đủ',
//       'EPO014': 'Pallet đã được định vị vào Bin/Point',
//       'EPO015': 'Pallet đã hoàn thành nhận hàng',
//       'EPO016': 'PA đã được định vị',
//       'EPO017': 'Pallet đã stow vào Bin',
//       'EPO018': 'Mã tham khảo đã tồn tại',
//       'EPO019': 'Đơn hàng đã nhận đủ',
//       'EPO020': 'Trạng thái Bin không hợp lệ',
//       'EPO021': 'Bin/Point chưa định vị Pallet',
//       'EPO022': 'Barcode/SKU không tồn tại',
//       'EPO023': 'TBLT không cùng loại tính chất hàng hoá',
//       'EPO024':
//       'Barcode/SKU cần luân chuyển đến PTVC không đúng tính chất hàng hoá',
//       'EPO025': 'Point đang có định vị Pallet. Vui lòng scan Pallet',
//       'EPO026': 'Vui lòng nhập HSD',
//       'JOB001': 'Không tạo được jobs',
//       'JOB002': 'Không xác đinh được jobs',
//       'JOB003': 'Không tìm thấy Bin hoặc Pallet',
//       'JOB004': 'Bạn chưa thực hiện xong job.',
//       'JOB005': 'Tài khoản đang thực hiện task khác.',
//       'JOB006': 'Lưu kho thất bại. Vui lòng kiểm tra lại!',
//       'EPIO001': 'Vượt quá số lượng lấy hàng trên Bin/Pallet',
//       'EPIO002': 'Không tìm thấy SKU trong PTVC',
//       'EPIO003': 'Không thể xác định được Job',
//       'EPIO004': 'Không tìm thấy PTVC',
//       'EPIO005': 'Không tìm thấy PTVC',
//       'EPIO006': 'Vui lòng đóng gói SO trên web trước khi scan điểm tập kết',
//       'EPIO007': 'Tote đã được thực hiện bởi nghiệp vụ khác',
//       'EPIO008': 'Không thể hoàn thành việc lấy hàng sau đóng gói',
//       'EPIO009': 'Pallet không chứa hàng',
//       'EPIO010': 'Điểm tập kết hàng không hợp lệ. Vui lòng nhập lại mã pallet!',
//       'EPIO011': 'Chưa có công việc được phân công.',
//       'EPI0013': 'Không xác định được Tote',
//       'EPI0014': 'Không xác định được Bin/Point/Pallet',
//       'EPI0015': 'Hàng đã chuyển vào điểm tập kết. Vui lòng kiểm tra lại!',
//       'EPI0016':
//       'Không tìm thấy Barcode của SKU được scan. Vui lòng kiểm tra lại!',
//       'EPI0017':
//       'Picklist đã được thực hiện bởi nhân viên khác. Vui lòng chọn Picklist khác!',
//       'EPI0018': 'Khu vực đóng gói không tồn tại. Vui lòng kiểm tra lại!',
//       'EPI0019': 'Khu vực đóng gói không hoạt động. Vui lòng nhập lại mã khác!',
//       'GE001': 'Mã SO không chính xác. Vui lòng nhập lại mã khác!',
//       'GE002': 'Trạng thái SO không hợp lệ. Vui lòng nhập lại mã khác!',
//       'GE003': 'SO chưa định vị vị trí tập kết. Vui lòng nhập lại mã khác!',
//       'GE004': 'Mã vị trí tập kết không chính xác. Vui lòng nhập lại mã khác!',
//       'GE005':
//       'Mã SO này đang được thực hiện tập kết hàng bởi 1 tài khoản khác!',
//       'EP0027': 'PTVC không tồn tại trên hệ thống. Vui lòng nhập lại mã khác!',
//       'EP0028': 'PTVC chưa được định vị',
//       'EP0029': 'PTVC này đang chứa Pallet. Vui lòng nhập lại mã pallet!',
//       'EP0030': 'PTVC này đang chờ xuất hàng. Vui lòng nhập lại mã pallet!',
//       'EP0031':
//       'Mã Barcode này không chứa trong PTVC. Vui lòng nhập lại mã barcode khác!',
//       'EP0032':
//       'Số lượng cần luân chuyển vượt quá số lượng cho phép. Vui lòng kiểm tra lại!',
//       'EP0033': 'Đây là PTVC. Vui lòng nhập lại mã khác!',
//       'EP0034':
//       'PTVC đích không đủ điều kiện để lưu trữ hàng chuyển vào. Vui lòng kiểm tra lại hoặc nhập mã khác!',
//       'EP0035': 'Mã barcode không hợp lệ',
//       'EP0036': 'PTVC đích chưa định vị đơn hàng xuất',
//       'EP0037': 'Vị trí lưu trữ không đúng. Vui lòng kiểm tra lại!',
//       'EP0038': 'Barcode trạng thái đã bị huỷ',
//       'EP0039': 'Barcode mặc định hệ thống không thể huỷ',
//       'EP0040': 'Vị trí lưu trữ chỉ chứa hàng sau đóng gói',
//       'EP0041': 'Không transfer trực tiếp qua Point',
//       'EP0042': 'PTVC không tồn tại trên hệ thống. Vui lòng nhập lại mã khác!',
//       'EP0043': 'PTVC không tồn tại trên hệ thống. Vui lòng nhập lại mã khác!',
//       'EP0044': 'PTVC này rỗng. Vui lòng nhập lại mã khác!',
//       'EP0045': 'PTVC này đang nhận hàng. Vui lòng nhập lại mã khác!',
//       'EP0046':
//       'PTVC này đã định vị trên vị trí lưu trữ. Không thể lưu kho. Vui lòng nhập lại mã khác!',
//       'EP0047':
//       'Mã Barcode này không chứa trong phương tiện vận chuyển. Vui lòng nhập lại mã barcode khác!',
//       'EP0048':
//       'Số lượng nhập vào vượt số lượng hàng sản phẩm chứa trong phương tiện vận chuyển .Vui lòng nhập lại số lượng!',
//       'EP0049': 'Không thể lưu hàng lẻ vào Point',
//       'EP0050': 'Loại hàng hoá của pallet không được phép lưu trữ trên PTVC.',
//       'EP0051': 'PTVC đích không đúng loại hàng hoá.',
//       'EI001': 'Không tìm thấy Barcode',
//       'EI002': 'Không tìm thấy SKU trong PO.',
//       'ESO001': 'Không tìm thấy SO',
//       'ESO002': 'Trạng thái SO đã HỦY',
//       'ESO003': 'Trạng thái SO không hợp lệ',
//       'KD001':
//       'Vị trí tập kết không tồn tại trên hệ thống. Vui lòng nhập lại mã khác!',
//       'KD002':
//       'Vị trí này không phải lả vị trí tập kết. Vui lòng nhập lại mã khác!',
//       'KD003': 'Vị trí tập này chưa chứa hàng. Vui lòng nhập lại mã khác!',
//       'KD004':
//       'Barcode này không tồn tại trong danh sách sản phẩm của SO. Vui lòng nhập lại mã khác!',
//       'KD005': 'Đã có lỗi xảy ra. vui lòng scan lại!',
//       'KD006': 'Không thể kết thúc công việc. Vui lòng kiểm tra lại!',
//       'KD007': 'Đã vượt quá số thùng chẵn. Vui lòng kiểm tra lại!',
//       'KD008': 'Đã vượt quá số thùng lẽ. Vui lòng kiểm tra lại!',
//       'ECO001': 'Không tìm thấy công việc thực hiện.',
//       'ECO002': 'PTVC không tồn tại. Vui lòng kiểm tra lại!',
//       'ECO003': 'Số lượng scan lớn hơn số lượng có trong PTVC',
//       'ECO004': 'SKU không nằm đúng PTVC',
//       'ECO005': 'PTVC không tìm thấy, vui lòng kiểm tra lại!',
//       'ECO007':
//       'PTLT này đang được sử dụng bởi 1 tài khoản khác. Vui lòng kiểm tra lại!',
//       'ECO010': 'Scan barcode thất bại. Vui lòng thực hiện lại!',
//       'ECO011': 'Số lượng nhập vượt quá số lượng trong PTVC.',
//       'ECO012': 'Đã có lỗi xảy ra khi kết thúc công việc. Vui lòng thử lại!',
//       'ECO013': 'Sản phẩm đã lưu trữ đủ hàng trên PTVC.',
//       'ECO014': 'Không tìm thấy Barcode cần xoá. Vui lòng kiểm tra lại!',
//       'ECO015':
//       'Số lượng cần xoá lớn hơn số lượng đã scan. Vui lòng kiểm tra lại!',
//       'LF0001':
//       'Bút toán đã được thực hiện bởi nhân viên khác. Vui lòng chọn bút toán khác!',
//       'LF0002': 'Đã có lỗi xảy ra. vui lòng thử lại!',
//       'LF0003': 'Thực hiện sai bút toán luân chuyển hàng tìm thấy.',
//       'LF0004': 'Công việc không xác định. vui lòng kiểm tra lại!',
//       'LF0005': 'PTLT không chính xác. Vui lòng nhập lại mã khác!',
//       'LF0006':
//       'Mã Barcode này không chính xác. Vui lòng nhập lại mã barcode khác!',
//       'LF0007': 'Số lượng không chính xác. Vui lòng nhập lại số lượng!',
//       'LF0008': 'PTLT không tồn tại trên hệ thống. Vui lòng nhập lại mã khác!',
//       'LF0009': 'Vị trí lưu trữ không phù hợp. Vui lòng nhập lại mã khác!'
//     };
//
//     return (msg[msgCode] != null) ? msg[msgCode] : 'Đã có lỗi xảy ra.';
//   }
// }
//
// ErrorEntity createErrorEntity(DioError error) {
//   switch (error.type) {
//     case DioErrorType.CANCEL:
//       return ErrorEntity(code: -1, message: tr('cancellation_request'));
//     case DioErrorType.CONNECT_TIMEOUT:
//       return ErrorEntity(code: -1, message: tr('connect_timeout'));
//     case DioErrorType.SEND_TIMEOUT:
//       return ErrorEntity(code: -1, message: tr('request_timed_out'));
//     case DioErrorType.RECEIVE_TIMEOUT:
//       return ErrorEntity(code: -1, message: tr('receive_timed_out'));
//     case DioErrorType.RESPONSE:
//       try {
//         final errCode = error.response.statusCode;
//         switch (errCode) {
//           case 400:
//             return ErrorEntity(
//                 code: errCode, message: tr('syntax_error_request'));
//           case 401:
//             return ErrorEntity(code: errCode, message: tr('access_denied'));
//           case 403:
//             return ErrorEntity(
//                 code: errCode, message: tr('the_server_refused_to_execute'));
//           case 404:
//             return ErrorEntity(
//                 code: errCode, message: tr('can_not_connect_to_server'));
//             break;
//           case 405:
//             return ErrorEntity(
//                 code: errCode, message: tr('the_request_method_is_prohibited'));
//           case 500:
//             return ErrorEntity(
//                 code: errCode, message: tr('server_internal_error'));
//           case 502:
//             return ErrorEntity(code: errCode, message: tr('invalid_request'));
//           case 503:
//             return ErrorEntity(
//                 code: errCode, message: tr('the_server_has_crashed'));
//           case 505:
//             return ErrorEntity(
//                 code: errCode,
//                 message: tr('does_not_support_HTTP_protocol_requests'));
//           default:
//             return ErrorEntity(
//                 code: errCode, message: error.response.statusMessage);
//         }
//       } on Exception catch (_) {
//         return ErrorEntity(code: -1, message: tr('an_unknown_error'));
//       }
//       break;
//     default:
//       if (error.message.contains('SocketException')) {
//         return ErrorEntity(code: -1, message: tr('no_network_connection'));
//       }
//       return ErrorEntity(code: -1, message: error.message);
//   }
// }
//
// class ErrorEntity implements Exception {
//   ErrorEntity({this.code, this.message});
//
//   int code;
//   String message;
//
//   @override
//   String toString() {
//     return (message == null) ? tr('an_unknown_error') : message;
//   }
// }
