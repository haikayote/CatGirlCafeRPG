class_name DayEnding extends CanvasLayer

@onready var button = $VBoxContainer/Button


func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
#if button is pressed:
# scene = day 2 bedroom w new dialogs
# remove other scene
# day 2 bedroom scene should have transition to day 2 lobby w / day 2 npcs
func _on_button_pressed() -> void:
	var level_scene = load("res://Levels/Area1/03.tscn")
	var level_instance = level_scene.instantiate()
	var player_spawn = level_instance.get_node("PlayerSpawn")
	LevelManager.load_new_level(("res://Levels/Area1/03.tscn"), ("res://Levels/Area1/03.tscn"),Vector2.ZERO)
	GlobalPlayerManager.set_player_position(player_spawn.global_position)
	pass
