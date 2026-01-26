class_name NPCBehavior extends Node2D

var npc : NPC


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p = get_parent()
	if p is NPC:
		npc = p as NPC
		#connect to signal here
	pass # Replace with function body.
