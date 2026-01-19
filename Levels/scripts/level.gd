class_name Level extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.y_sort_enabled = true
	GlobalPlayerManager.set_as_parent(self)
