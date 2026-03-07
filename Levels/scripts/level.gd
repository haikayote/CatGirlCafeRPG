class_name Level extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	self.y_sort_enabled = true
	GlobalPlayerManager.set_as_parent(self)
	LevelManager.level_load_started.connect(_free_level)

func _free_level() -> void:
	GlobalPlayerManager.unparent_player(self)
	queue_free() #player won't be part of the previous level when level is removed from the game
	pass
