extends Node

var whiteGreenFont: BitmapFont
var yellowBlackFont: BitmapFont

func _ready():
	whiteGreenFont = prepare_font("res://assets/graphics/ui/fonts/PixelFontWhiteGreen.png")
	yellowBlackFont = prepare_font("res://assets/graphics/ui/fonts/PixelFontBG.png")

func prepare_font(textureResource: String):
	var font = BitmapFont.new()
	var texture = load(textureResource)
	var chars = '!"#$%&' + "'" + '()*+,-./0ABCDEFGHIJKLMNÑO`abcdefghijklmnñ123456789:;<=>?@PQRSTUVWXYZ[\\]^_opqrstuvwxyz{|}~'
	var line = -1
	font.add_texture(texture)
	for i in range (0, chars.length()):
		if i % 16 == 0:
			line += 1
		font.add_char(chars.ord_at(i), 0, Rect2(8 * (i - line * 16), 8 * line, 8, 8), Vector2(0, 0), 8)
	return font
