extends Area2D

@export var item_name: String = "Другий предмет"
var is_dropped: bool = false

func _ready() -> void:
	visible = false
	monitoring = false
	body_entered.connect(_on_body_entered)

func drop_from_door() -> void:
	is_dropped = true
	visible = true
	monitoring = true
	
	await get_tree().physics_frame
	for body in get_overlapping_bodies():
		_on_body_entered(body)

func _on_body_entered(body: Node2D) -> void:
	if is_dropped and body is CharacterBody2D:
		print("Підібрано: ", item_name)
		queue_free()
