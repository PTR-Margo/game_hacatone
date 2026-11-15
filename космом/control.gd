extends Control

@export_file("*.tscn") var next_scene_after_video: String = "" # Сцена після відео (якщо потрібна)

@onready var video_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var fade_rect: ColorRect = $FadeRect

func _ready() -> void:
	# 1. Запускаємо відео і одночасно плавно прибираємо чорний екран (висвітлення за 1.5 сек)
	video_player.play()
	var fade_in = create_tween()
	fade_in.tween_property(fade_rect, "color:a", 0.0, 1.5)
	
	# 2. Чекаємо, поки відео закінчиться
	await video_player.finished
	
	# 3. Знову плавно затемнюємо екран в кінці відео за 1.5 сек
	var fade_out = create_tween()
	fade_out.tween_property(fade_rect, "color:a", 1.0, 1.5)
	await fade_out.finished
	
	# 4. Переходимо далі (наприклад, на наступний рівень або в меню), якщо вказано сцену
	if next_scene_after_video != "":
		get_tree().change_scene_to_file(next_scene_after_video)
