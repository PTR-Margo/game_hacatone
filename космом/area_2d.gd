extends Area2D

@export var target_scene: String = ""
@export var target_spawn_name: String = "SpawnLeft"

func _ready() -> void:
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and target_scene != "":
		Engine.set_meta("spawn_point", target_spawn_name)
		get_tree().call_deferred("change_scene_to_file", target_scene)
