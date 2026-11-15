
extends CanvasLayer

@onready var frame = $TextureRect
@onready var dialogue_text = $TextureRect/dialog1

var message = "Привіт, мандрівнику! Ласкаво просимо у наш світ."

func _ready():
	# Початкове положення рамки
	frame.position.y = -300


	# Чекаємо 2 секунди
	await get_tree().create_timer(2.0).timeout

	# Рамка виїжджає зверху вниз
	var tween = create_tween()
	tween.tween_property(
		frame,
		"position:y",
		30,
		1.0
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	await tween.finished

	# Друкуємо текст
	for letter in message:
		await get_tree().create_timer(0.04).timeout
