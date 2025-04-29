import 'dart:convert';

import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meory/data/data_source/remote/base_repository.dart';
import 'package:meory/data/models/entry/entry_model.dart';
import 'package:meory/domain/repositories/openai/openai_repo.dart';

class OpenaiRepoImpl extends BaseRepository with OpenaiRepo {
  OpenaiRepoImpl() : super() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        logRequest(options);
        return handler.next(options);
      },
      onResponse: (response, handler) {
        logResponse(response);

        return onResponse(response, handler);
      },
      onError: (e, handler) async {
        if (e.response != null) {
          logResponse(e.response!);
        }

        return onError(e, handler);
      },
    ));
  }
  final Dio _dio = Dio(
    BaseOptions(
      // baseUrl: 'https://api.openai.com/v1',
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization':
        //     'Bearer ',
      },
    ),
  );

  String cleanJsonString(String raw) {
    return raw
        .trim()
        .replaceAll(RegExp(r'^```json'), '')
        .replaceAll(RegExp(r'```[\s\r\n]*$'), '')
        .replaceAll(RegExp('\\"'), '"');
  }

  @override
  Future<Result<List<EntryModel>>> getPromptWord({required String word}) async {
    final struct = EntryModel(
      definition: "...",
      partsOfSpeech: PartsOfSpeechE.noun,
      pronunciation: "...",
      category: "...",
      topic: "...",
    ).toJsonAsk().toString();
    final explain =
        "partsOfSpeech là index của mảng sau ${PartsOfSpeechE.values.map((e) => e.name).toList().toString()}";
    final ask =
        "Giải thích: $explain. Câu hỏi: Hãy dịch từ $word sang tiếng Việt. Trả lời bằng JSON với cấu trúc: [$struct]. Nếu từ $word có nhiều nghĩa thì bạn cho nhiều trả lời vào mảng, tối đa 3 nghĩa. Chuỗi json trả về dạng json bình thường mà không cần phải để ở dạng markdown json";
    final apiKey = dotenv.env['API_KEY'];
    final url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey';
    try {
      Log.d('Request open ai: $ask');
      final response = await _dio.post(
        url,
        data: {
          "contents": [
            {
              "role": "user",
              "parts": [
                {"text": ask}
              ]
            }
          ]
        },
      );

      // final reply = response.data['choices'][0]['message']['content'];
      final jsonData = response.data['candidates'][0]['content']['parts'][0]['text'];
      final jsonClear = cleanJsonString(jsonData);
      Log.w('Response open ai: $jsonClear');
      final mapData = jsonDecode(jsonClear);
      if (mapData is Map) {
        return Result.success([EntryModel.fromJson(mapData as Map<String, dynamic>)]);
      }
      if (mapData is List) {
        return Result.success(
          mapData.map((e) => EntryModel.fromJson(e as Map<String, dynamic>)).toList(),
        );
      }
      return Result.success(null);
    } catch (e) {
      return Result.error('Lỗi khi gửi request: $e', e);
    }
  }

  Future<Result<String>> getPromptWordOpenai({required String word}) async {
    final struct = EntryModel(
      definition: "...",
      partsOfSpeech: PartsOfSpeechE.noun,
      pronunciation: "...",
      category: "...",
      topic: "...",
    ).toJsonAsk().toString();
    final explain =
        "partsOfSpeech là index của mảng sau ${PartsOfSpeechE.values.map((e) => e.name).toList().toString()}";
    final ask =
        "Giải thích: $explain. Câu hỏi: Hãy dịch từ $word sang tiếng Việt. Trả lời bằng JSON với cấu trúc: [$struct]. Nếu từ $word có nhiều nghĩa thì bạn cho nhiều trả lời vào mảng, tối đa 3 nghĩa.";
    try {
      Log.d('Request open ai: $ask');
      final response = await _dio.post(
        '/responses', // '/chat/completions',
        data: {
          "model": "gpt-3.5-turbo",
          // "messages": [
          //   {"role": "system", "content": "Bạn là trợ lý thân thiện."},
          //   {"role": "user", "content": ask}
          // ],
          'input': ask,
          // "temperature": 0.7,
          // "max_tokens": 512,
        },
      );

      // final reply = response.data['choices'][0]['message']['content'];
      final reply = response.toString();
      return Result.success(reply);
    } catch (e) {
      return Result.error('Lỗi khi gửi request: $e', e);
    }
  }
}
