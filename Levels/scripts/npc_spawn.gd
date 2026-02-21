extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalNpcManager.npc_spawned == false:
		GlobalNpcManager.set_npc_position(global_position)
		GlobalNpcManager.npc_spawned = true
