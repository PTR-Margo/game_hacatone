extends Area2D

@export var item_name: String = "Шостий предмет"
var is_dropped: bool = false

func _ready() -> void:
	# Ховаємо предмет на старті і вимикаємо кліки миші, щоб не перекривав двері/шафку
	visible = false
	monitoring = false
	input_pickable = false
	body_entered.connect(_on_body_entered)

# Цю функцію викликають шості двері/шафка при натисканні
func drop_from_door() -> void:
	is_dropped = true
	visible = true
	monitoring = true
	
	# Чекаємо 1 фізичний кадр і перевіряємо, чи гравець вже не стоїть на предметі
	await get_tree().physics_frame
	for body in get_overlapping_bodies():
		_on_body_entered(body)

func _on_body_entered(body: Node2D) -> void:
	if is_dropped and body is CharacterBody2D:
		print("Підібрано: ", item_name)
		get_tree().current_scene.item_collected()
		queue_free()
		
