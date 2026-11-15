extends Area2D

@export_file("*.tscn") var target_scene: String = "" # В яку кімнату переходимо
@export var target_spawn_name: String = "SpawnLeft" # Назва точки появи у ТІЙ кімнаті

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and target_scene != "":
		Engine.set_meta("spawn_point", target_spawn_name)
		get_tree().call_deferred("change_scene_to_file", target_scene)
