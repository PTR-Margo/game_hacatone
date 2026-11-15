extends Node

@export var total_items: int = 6 # Загальна кількість предметів на рівні
@export_file("*.tscn") var video_scene: String = "" # Шлях до сцени з відео (виберемо в інспекторі)

@onready var fade_rect: ColorRect = get_node_or_null("CanvasLayer/FadeRect")
var collected_items: int = 0

func item_collected() -> void:
	collected_items += 1
	print("Зібрано предметів: ", collected_items, " з ", total_items)
	
	if collected_items >= total_items:
		start_cutscene_sequence()

func start_cutscene_sequence() -> void:
	# 1. Чекаємо 2.5 секунди після підбору останнього предмета
	await get_tree().create_timer(2.5).timeout
	
	# 2. Плавно затемнюємо екран за 1.5 секунди (якщо FadeRect додано в сцену)
	if fade_rect != null:
		var tween = create_tween()
		tween.tween_property(fade_rect, "color:a", 1.0, 1.5)
		await tween.finished
	else:
		print("ПОПЕРЕДЖЕННЯ: Не знайдено CanvasLayer/FadeRect, переходимо без затемнення.")
	
	# 3. Переходимо на сцену з відео
	if video_scene != "" and ResourceLoader.exists(video_scene):
		get_tree().change_scene_to_file(video_scene)
	else:
		print("ПОМИЛКА: Сцена відео не вказана або файл не знайдено! Шлях: ", video_scene)
