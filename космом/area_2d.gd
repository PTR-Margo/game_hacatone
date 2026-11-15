
extends Area2D

@export var target_spawn_name: String = "SpawnLeft"

var target_scene: String = "res://Game_scene3.tscn"
var is_transitioning: bool = false

func _ready() -> void:
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not is_transitioning:
		is_transitioning = true

		print("Гравець увійшов у тригер!")
		print("Шлях до сцени: ", target_scene)

		Engine.set_meta("spawn_point", target_spawn_name)

		var result = get_tree().change_scene_to_file(target_scene)

		print("Результат переходу: ", result)

		if result != OK:
			print("Помилка завантаження сцени: ", result)
			is_transitioning = false
