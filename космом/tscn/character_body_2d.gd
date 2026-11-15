extends CharacterBody2D

@export var speed = 200

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")

	velocity.x = direction * speed

	if direction != 0:
		anim.play("run")
		
		if direction > 0:
			anim.flip_h = false
		else:
			anim.flip_h = true
	else:
		anim.play("idle")

	move_and_slide()
