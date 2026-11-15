extends Area2D

# Сюди в інспекторі перетягуємо четвертий предмет
@export var item_to_drop: Area2D
var is_opened: bool = false

func _ready() -> void:
	input_event.connect(_on_input_event)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not is_opened and item_to_drop != null:
			is_opened = true
			item_to_drop.drop_from_door()
