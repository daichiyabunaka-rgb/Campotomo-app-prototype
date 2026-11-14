import 'dart:math' as math;

import '../models.dart';

/// モックユーザーは「anchor（中心点）からの相対距離」で配置する。
/// anchor には実 GPS で取得した現在地が入り、どこにいても近くのキャンとも候補が並ぶ。
class _MockSpec {
  final String id;
  final String nickname;
  final String decade;
  final String gender;
  final String iconCategoryId;
  final List<String> interestIds;
  final String bio;
  final double northKm; // anchor からの北方向距離
  final double eastKm; // anchor からの東方向距離

  const _MockSpec(this.id, this.nickname, this.decade, this.gender,
      this.iconCategoryId, this.interestIds, this.bio, this.northKm,
      this.eastKm);
}

const List<_MockSpec> _specs = [
  _MockSpec(
    'u-tent-ken',
    'ソロキャンのけん',
    '30代',
    'male',
    'tent',
    ['tent', 'fire', 'solo'],
    '週末はほぼソロキャン。薪の焚き火を眺めながらの夜が至福です。',
    0.6,
    0.2,
  ),
  _MockSpec(
    'u-cook-akira',
    '飯盒さんのあきら',
    '40代',
    'male',
    'cook',
    ['cook', 'bbq', 'group'],
    'ダッチオーブンと飯盒が主戦力。朝は珈琲と焼きたてパンと決めています。',
    -0.3,
    -0.1,
  ),
  _MockSpec(
    'u-fire-nana',
    '焚き火のなな',
    '20代',
    'female',
    'fire',
    ['fire', 'star', 'photo'],
    '焚き火を見ながらの夜キャンプが好き。星空撮影も少しだけやっています。',
    0.15,
    -0.4,
  ),
  _MockSpec(
    'u-star-sora',
    '天体観測のそら',
    '20代',
    'undisclosed',
    'star',
    ['star', 'photo', 'winter'],
    '月のない夜は山へ。天体撮影キャンプ歴5年です。冬キャンプも得意です。',
    -0.7,
    0.5,
  ),
  _MockSpec(
    'u-bike-miu',
    'バイクキャンプのみう',
    '20代',
    'female',
    'bikecamp',
    ['bikecamp', 'solo', 'gear'],
    '大型バイクでのツーリングキャンプが趣味。荷物は最小限にする派です。',
    1.2,
    -0.9,
  ),
  _MockSpec(
    'u-gear-kei',
    'ギア研のけい',
    '30代',
    'undisclosed',
    'gear',
    ['gear', 'tent', 'photo'],
    'アウトドアギアの勉強中。テントは4張り保有。見せ合い・貸し借り歓迎。',
    -1.1,
    1.0,
  ),
  _MockSpec(
    'u-coffee-hina',
    '朝コーヒーのひな',
    '30代',
    'female',
    'coffee',
    ['coffee', 'cook', 'solo'],
    'キャンプの朝はハンドドリップから。おいしい豆の情報交換しましょう。',
    0.9,
    0.35,
  ),
  _MockSpec(
    'u-photo-kyo',
    '撮影担当のきょう',
    '40代',
    'male',
    'photo',
    ['photo', 'fire', 'group'],
    '焚き火とテントの夜景撮影が専門。撮るのも撮られるのも両方やります。',
    0.45,
    -1.3,
  ),
];

class _BusinessSpec {
  final String id;
  final String nickname;
  final String iconCategoryId;
  final String storeType;
  final String bio;
  final double northKm;
  final double eastKm;

  const _BusinessSpec(this.id, this.nickname, this.iconCategoryId,
      this.storeType, this.bio, this.northKm, this.eastKm);
}

const List<_BusinessSpec> _businessSpecs = [
  _BusinessSpec(
    'b-camp-midori',
    'キャンプ場 みどり湖畔サイト',
    'tent',
    'キャンプ場・グランピング',
    '薪・レンタルギアも豊富。デイキャンプも大歓迎。焚き火スペースもご相談ください。',
    0.8,
    0.9,
  ),
  _BusinessSpec(
    'b-shop-pine',
    'アウトドア用品店 パインウェブ',
    'gear',
    'アウトドア用品店',
    'テント・焚き火台・クーラーボックスの在庫多数。組み立ては当店スタッフがお手伝いします。',
    -0.5,
    1.1,
  ),
  _BusinessSpec(
    'b-rental-cedar',
    'レンタルギア シーダー',
    'tent',
    'レンタルギア・アウトドア',
    '手ぶらさん歓迎のレンタルギア屋。一式3,000円〜。受け取りは当店前で。',
    1.5,
    -0.6,
  ),
  _BusinessSpec(
    'b-kafe-woodsmoke',
    'Cafe&焚き火 ウッドスモーク',
    'bbq',
    'キャンプ飯カフェ・食堂',
    '焚き火を囲めるカフェです。食材の持ち込みBBQスペースも予約できます。',
    -1.4,
    -0.8,
  ),
];

const double _kmPerDegLat = 111.32;

AppUser _specToUser(_MockSpec s, double anchorLat, double anchorLng) {
  final cos =
      math.cos(anchorLat * math.pi / 180.0).abs().clamp(0.01, 1.0);
  return AppUser(
    id: s.id,
    nickname: s.nickname,
    decade: s.decade,
    gender: s.gender,
    iconCategoryId: s.iconCategoryId,
    interestIds: s.interestIds,
    bio: s.bio,
    lat: anchorLat + s.northKm / _kmPerDegLat,
    lng: anchorLng + s.eastKm / (_kmPerDegLat * cos),
  );
}

BusinessUser _specToBusiness(
    _BusinessSpec s, double anchorLat, double anchorLng) {
  final cos =
      math.cos(anchorLat * math.pi / 180.0).abs().clamp(0.01, 1.0);
  return BusinessUser(
    id: s.id,
    nickname: s.nickname,
    decade: '経営者',
    gender: 'undisclosed',
    iconCategoryId: s.iconCategoryId,
    interestIds: const [],
    bio: s.bio,
    lat: anchorLat + s.northKm / _kmPerDegLat,
    lng: anchorLng + s.eastKm / (_kmPerDegLat * cos),
    storeType: s.storeType,
  );
}

/// 現在地を中心にモックユーザー（一般 + ビジネス）を配置する。
List<AppUser> buildMockUsers(double anchorLat, double anchorLng) {
  return [
    for (final s in _specs) _specToUser(s, anchorLat, anchorLng),
    for (final s in _businessSpecs) _specToBusiness(s, anchorLat, anchorLng),
  ];
}

/// シード募集（起動時刻からの残り時間で作るので、いつ開いても「今から」感が出る）。
/// host は generalUsers（モック一般ユーザー）から id で引く。
List<Recruitment> seedRecruitments(DateTime now, List<AppUser> generalUsers) {
  Recruitment make({
    required String hostId,
    required String genreId,
    required String title,
    required String body,
    required String meetup,
    required int capacity,
    required int minutesLeft,
  }) {
    return Recruitment(
      id: 'r-$hostId',
      hostId: hostId,
      genreId: genreId,
      title: title,
      body: body,
      meetup: meetup,
      capacity: capacity,
      createdAt: now.subtract(const Duration(minutes: 15)),
      expiresAt: now.add(Duration(minutes: minutesLeft)),
      memberIds: [hostId],
    );
  }

  return [
    make(
      hostId: 'u-tent-ken',
      genreId: 'daycamp',
      title: '今から河原で焚き火しませんか',
      body: 'デイキャンでのんびり焚き火です。椅子とコーヒーは余分にあるので手ぶらでOK。',
      meetup: 'みどり湖畔サイト デイキャン区画',
      capacity: 3,
      minutesLeft: 105,
    ),
    make(
      hostId: 'u-cook-akira',
      genreId: 'overnight',
      title: '今夜は飯盒ごはんキャンプをしませんか',
      body: 'ダッチオーブンでローストポークを作ります。朝はパンを焼くので早起きは任意です。',
      meetup: 'みどり湖畔サイト 管理棟前',
      capacity: 3,
      minutesLeft: 70,
    ),
    make(
      hostId: 'u-photo-kyo',
      genreId: 'daycamp',
      title: '今夜の星空撮影キャンプ、同行しませんか',
      body: '天体撮影の同行カメラさんを探しています。三脚の貸出もできます。',
      meetup: '星空が見える 第2サイト',
      capacity: 4,
      minutesLeft: 160,
    ),
    make(
      hostId: 'u-coffee-hina',
      genreId: 'daycamp',
      title: '焚き火でお茶会しませんか',
      body: 'ハンドドリップの珈琲とお菓子を持って集まりませんか。ギア自慢も大歓迎です。',
      meetup: 'みどり湖畔サイト 焚き火スペース',
      capacity: 2,
      minutesLeft: 95,
    ),
    make(
      hostId: 'u-gear-kei',
      genreId: 'gearmeet',
      title: 'ギア自慢・見せ合い会をやります',
      body: '新調した焚き火台とスツールを見せ合う会です。困ったギアの相談にも乗ります。',
      meetup: 'アウトドア用品店 パインウェブ 駐車場',
      capacity: 4,
      minutesLeft: 130,
    ),
    make(
      hostId: 'u-bike-miu',
      genreId: 'gearmeet',
      title: '次のツーリングキャンプ、合同しませんか',
      body: '林道の先のキャンプ場を予定しています。ツーリング好きもキャンプ好きも歓迎です。',
      meetup: 'アウトドア用品店 パインウェブ 前',
      capacity: 3,
      minutesLeft: 45,
    ),
  ];
}

/// ゆずりあい・交換のシード。anchor（現在地）からの相対距離で配置する。
/// id が 'cx-seed-' 始まりのものは GPS 更新のたびに再配置される
/// （AppState.applyGps を参照）。
class _ExchangeSeedSpec {
  final String id;
  final String posterId;
  final String kind;
  final String itemDescription;
  final String areaName;
  final String detail;
  final double northKm;
  final double eastKm;
  final Duration age;
  const _ExchangeSeedSpec(this.id, this.posterId, this.kind,
      this.itemDescription, this.areaName, this.detail, this.northKm,
      this.eastKm, this.age);
}

const List<_ExchangeSeedSpec> _exchangeSeedSpecs = [
  _ExchangeSeedSpec(
    'cx-seed-1',
    'u-fire-nana',
    'give',
    '焚き火台（五徳付き・使用済み・清掃済み）',
    'みどり湖畔サイト 周辺',
    '買い替えで手元に余裕が出たので、'
        '使ってくださる方にゆずります。手渡し前提です。',
    0.3,
    -0.6,
    Duration(hours: 2),
  ),
  _ExchangeSeedSpec(
    'cx-seed-2',
    'u-bike-miu',
    'wanted',
    'コンパクトなカセットコンロを探しています',
    '駅裏の駐車場 周辺',
    'ツーリング用の小さいものを探しています。不要ギアとの'
        '交換の対応も可能です。DMお待ちしています。',
    -0.2,
    0.8,
    Duration(hours: 5),
  ),
  _ExchangeSeedSpec(
    'cx-seed-3',
    'u-gear-kei',
    'trade',
    'ガスランタンと LEDランタンを交換します',
    '市役所裏の駐車場 周辺',
    '充電式に買い替えたいので交換希望です。状態は写真で'
        '送ります。公共の駐車場で受け渡しできます。',
    -0.9,
    -0.3,
    Duration(hours: 26),
  ),
];

List<GearExchange> buildSeedGearExchanges(
    DateTime now, double anchorLat, double anchorLng) {
  final cos = (anchorLat * math.pi / 180.0).abs().clamp(0.01, 1.0);
  return [
    for (final s in _exchangeSeedSpecs)
      GearExchange(
        id: s.id,
        posterId: s.posterId,
        kind: s.kind,
        itemDescription: s.itemDescription,
        areaName: s.areaName,
        detail: s.detail,
        lat: anchorLat + s.northKm / _kmPerDegLat,
        lng: anchorLng + s.eastKm / (_kmPerDegLat * cos),
        createdAt: now.subtract(s.age),
      ),
  ];
}

/// モックの返信候補（デモの自動応答に使う。本開発では Supabase Realtime に置換）
const List<String> mockReplies = [
  'よろしくお願いします！',
  '次のキャンプ、楽しみですね。',
  '先に着いてサイトを取っておきますね。',
  '焚き火の薪は余分にあるので手ぶらでどうぞ。',
];

/// モックの応募メッセージ
const List<String> mockApplyMessages = [
  '参加したいです！キャンプ仲間を探していました。',
  '同じギアを使っているので嬉しいです。',
  'この近くでよくキャンプしています。',
];
