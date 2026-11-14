"""キャンとも！配布用アプリアイコン（1024px）を作るスクリプト。
Pillow でフラットデザインのテント（焚き火付き）を描く。生成物:
  - app/assets/icon/app_icon.png      （flutter_launcher_icons のソース）
"""
from PIL import Image, ImageDraw

SIZE = 1024
BG = (232, 236, 242)        # ライトグレー（シリーズ共通の落ち着いた背景色）
TENT = (48, 96, 68)         # テント本体（フォレストグリーン）
TENT_DARK = (33, 70, 50)     # テントの開き（濃い緑）
POLE = (46, 58, 74)          # ポール（ダークネイビー）
FIRE = (245, 158, 11)        # 焚き火（オレンジ。キャンプのアクセント）
SMOKE = (156, 163, 175)      # 煙（ライトスレート）


def rounded(im: Image.Image, radius: int) -> Image.Image:
    mask = Image.new("L", im.size, 0)
    d = ImageDraw.Draw(mask)
    d.rounded_rectangle([0, 0, SIZE - 1, SIZE - 1], radius=radius, fill=255)
    out = Image.new("RGBA", im.size, (0, 0, 0, 0))
    out.paste(im, (0, 0), mask)
    return out


def draw_tent():
    im = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)

    # 背景（角丸ライトグレー）
    d.rounded_rectangle([0, 0, SIZE - 1, SIZE - 1], radius=192, fill=BG + (255,))

    cx = SIZE // 2
    apex_y = 200       # テントの頂点
    base_y = 720       # テントの底辺
    half_w = 300       # 底辺の半分幅

    # ポール（頂点から上に少し伸びる）
    d.line([(cx, apex_y), (cx, apex_y - 70)], fill=POLE + (255,), width=22)

    # テント本体（三角形）
    d.polygon(
        [(cx, apex_y), (cx - half_w, base_y), (cx + half_w, base_y)],
        fill=TENT + (255,),
    )

    # 入り口（中央の開き。濃い緑の三角形）
    door_w = 120
    d.polygon(
        [(cx, apex_y + 110), (cx - door_w, base_y), (cx + door_w, base_y)],
        fill=TENT_DARK + (255,),
    )

    # 底辺の地面ライン
    d.line(
        [(cx - half_w - 60, base_y + 14), (cx + half_w + 60, base_y + 14)],
        fill=POLE + (255,),
        width=14,
    )

    # 焚き火（テントの右下）
    fx, fy = cx + 330, base_y - 40
    # 薪（2本クロス）
    d.line([(fx - 70, fy + 30), (fx + 70, fy - 20)], fill=POLE + (255,), width=24)
    d.line([(fx - 70, fy - 20), (fx + 70, fy + 30)], fill=POLE + (255,), width=24)
    # 炎（オレンジの三角形2枚）
    d.polygon(
        [(fx, fy - 110), (fx - 44, fy - 6), (fx + 44, fy - 6)],
        fill=FIRE + (255,),
    )
    d.polygon(
        [(fx, fy - 60), (fx - 22, fy), (fx + 22, fy)],
        fill=(250, 204, 21, 255),
    )
    # 煙
    d.arc([fx - 14, fy - 190, fx + 46, fy - 130], start=200, end=340, fill=SMOKE + (255,), width=12)
    d.arc([fx - 30, fy - 230, fx + 34, fy - 170], start=160, end=360, fill=SMOKE + (255,), width=12)

    return im


if __name__ == "__main__":
    im = draw_tent()
    im = rounded(im, 192)
    out = r"..\app\assets\icon\app_icon.png"
    im.save(out)
    print("saved:", out)
