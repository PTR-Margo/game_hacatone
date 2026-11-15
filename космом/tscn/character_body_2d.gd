extends CharacterBody2D

@export var speed = 200

@onready var anim: AnimatedSprite2D = get_node_or_null("AnimatedSprite2D")

func _ready() -> void:
	if Engine.has_meta("spawn_point"):
		var point_name: String = Engine.get_meta("spawn_point")
		if point_name != "":
			var spawn_node = get_tree().current_scene.get_node_or_null(point_name)
			if spawn_node != null:
				global_position = spawn_node.global_position
		Engine.set_meta("spawn_point", "")

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

	if anim != null:
		if direction != 0:
			anim.play("run")
			anim.flip_h = direction < 0
		else:
			anim.play("idle")

	move_and_slide()
