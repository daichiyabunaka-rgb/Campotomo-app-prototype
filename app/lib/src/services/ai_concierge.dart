import '../models.dart';

/// AI接客のデモ応答ロジック（プロトタイプ用のモック）。
/// 本開発では LLM API に置き換える。このロジックは店舗業態と
/// ユーザーの興味カテゴリからおすすめを案内する最低限のルールベース。
class AiConcierge {
  /// 最初の挨拶（店舗の口調 + ユーザーの興味を踏まえる）
  String greeting(AppUser me, BusinessUser store) {
    final interest = me.interestIds.isNotEmpty ? me.interestIds.first : null;
    final label = interest == null ? null : _categoryLabel(interest);
    final base = '${_opener(store)}'
        '${me.nickname}さん、${store.nickname}（${store.storeType}）のAI接客です。';
    if (label == null) {
      return '$base キャンプ・ギアのことなら何でも聞いてください。';
    }
    return '$base $labelがお好みなんですね。'
        'うちの${_recommend(store)}がおすすめです。';
  }

  /// 店舗タイプごとの口調（本開発では LLM に店舗キャラ設定を渡して生成する）
  String _opener(BusinessUser store) {
    switch (store.storeType) {
      case 'キャンプ場・グランピング':
        return 'いらっしゃい！焚き火スペースもご案内できますよ。';
      case 'アウトドア用品店':
        return 'いらっしゃいませ。ギア探しもお手伝いします。';
      case 'レンタルギア・アウトドア':
        return 'こんにちは。手ぶらでのご利用も大歓迎です。';
      case 'キャンプ飯カフェ・食堂':
        return 'いらっしゃい。食材の持ち込みBBQスペースもありますよ。';
      case '薪・燃料・雑貨':
        return 'ようこそ。薪も炭も当日に買い足せますよ。';
      default:
        return 'いらっしゃいませ。';
    }
  }

  /// ユーザー発話への応答
  String reply(String input, AppUser me, BusinessUser store) {
    final text = input.replaceAll(RegExp(r'\s'), '');
    if (text.contains('予約') || text.contains('来店') || text.contains('利用')) {
      return 'ありがとうございます。土日は混み合うため、'
          '平日の午前中でしたらゆっくりご案内できます。'
          'ご希望の時間をメモしておきますね。'
          '（デモのため実際の予約機能は本開発で提供します）';
    }
    if (text.contains('おすすめ') || text.contains('オススメ')) {
      return '今回は${_recommend(store)}がおすすめです。'
          'キャンプの予定や気になるギアがあれば教えてください。';
    }
    if (text.contains('ギア') || text.contains('テント') ||
        text.contains('薪')) {
      return '初めての方も歓迎しています。'
          'ご希望のスタイルに合わせて相談しながら選びます。';
    }
    if (text.contains('料金') || text.contains('いくら') ||
        text.contains('価格')) {
      return 'ご利用内容によって変わりますが、まずは一度お試しいただけます。'
          '詳しいプランは店舗ページをご確認ください（デモの固定値です）。';
    }
    if (text.contains('何時') || text.contains('営業時間')) {
      return '本日は10:00〜18:00で営業しております。'
          '混雑しやすいのは土曜午前です。（デモの固定値です）';
    }
    if (text.contains('トイレ') || text.contains('休憩')) {
      return 'トイレと休憩スペースを備えています。'
          'お飲み物の自販機もありますので、ご利用ください。';
    }
    return '承知しました。「おすすめ」「料金」「営業時間」「予約」「ギア」など、'
        '気になることを聞いていただければ答えます。';
  }

  String _recommend(BusinessUser store) {
    switch (store.storeType) {
      case 'キャンプ場・グランピング':
        return '焚き火スペース付きのデイキャンププラン';
      case 'アウトドア用品店':
        return '今季の焚き火台とスツールのセット';
      case 'レンタルギア・アウトドア':
        return '手ぶらキャンプ一式レンタル（3,000円〜）';
      case 'キャンプ飯カフェ・食堂':
        return '焚き火を囲む持ち込みBBQスペース';
      case '薪・燃料・雑貨':
        return '焚き火用の薪と着火剤のセット';
      default:
        return 'おすすめサービス';
    }
  }

  String _categoryLabel(String id) {
    const labels = {
      'tent': 'テント・タープ',
      'fire': '焚き火・薪',
      'cook': 'キャンプ飯',
      'bbq': 'BBQ・網焼き',
      'coffee': 'コーヒー・休憩',
      'gear': 'アウトドアギア',
      'solo': 'ソロキャン',
      'group': 'グルキャン・ファミキャン',
      'bikecamp': 'ツーリングキャンプ',
      'winter': '冬キャンプ',
      'star': '星空・天体観察',
      'photo': 'キャンプ写真',
    };
    return labels[id] ?? 'キャンプのこと';
  }
}

/// グローバルインスタンス（本開発では DI / LLM API クライアントに置き換える）
final AiConcierge aiConcierge = AiConcierge();
