extends CanvasLayer

@onready var frame = $TextureRect
@onready var dialogue_text = $TextureRect/inf1

var dialogues = [
	"I should make sure everything’s intact before the mission.",
	"I need to check my equipment",
    "I remember we were supposed to have 6 subjects..."
]

var current_dialogue = 0
var is_typing = false
var can_continue = false

func _ready():
	frame.position.y = -300
	dialogue_text.text = ""

	await get_tree().create_timer(2.0).timeout

	var tween = create_tween()
	tween.tween_property(
		frame,
		"position:y",
		30,
		1.0
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

	await tween.finished

	show_dialogue()

func show_dialogue():
	dialogue_text.text = ""
	can_continue = false
	is_typing = true

	var message = dialogues[current_dialogue]

	for letter in message:
		dialogue_text.text += letter
		await get_tree().create_timer(0.04).timeout

	is_typing = false
	can_continue = true

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if is_typing:
			return

		if can_continue:
			current_dialogue += 1

			if current_dialogue < dialogues.size():
				show_dialogue()
			else:
				hide()
