import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");  // .env 파일 로드
  String? clientId = dotenv.env['NAVER_MAP_CLIENT_ID'];  // .env 파일에서 클라이언트 ID 가져오기
  if (clientId == null) {
    log("네이버맵 클라이언트 ID를 찾을 수 없습니다.", name: "initialize");
    return;
  }

  await NaverMapSdk.instance.initialize(
    clientId: clientId,  // 클라이언트 ID 설정
    onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"),
  );

  runApp(const NaverMapApp());
}

class NaverMapApp extends StatelessWidget {
  const NaverMapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NaverMapScreen(),
    );
  }
}

class NaverMapScreen extends StatelessWidget {
  const NaverMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    final Completer<NaverMapController> mapControllerCompleter = Completer();

    return Scaffold(
      body: NaverMap(
        options: const NaverMapViewOptions(
          indoorEnable: true,             // 실내 맵 사용 가능 여부 설정
          locationButtonEnable: false,    // 위치 버튼 표시 여부 설정
          consumeSymbolTapEvents: false,  // 심볼 탭 이벤트 소비 여부 설정
        ),
        onMapReady: (controller) async {                // 지도 준비 완료 시 호출되는 콜백 함수
          mapControllerCompleter.complete(controller);  // Completer에 지도 컨트롤러 완료 신호 전송
          log("onMapReady", name: "onMapReady");
        },
      ),
    );
  }
}
