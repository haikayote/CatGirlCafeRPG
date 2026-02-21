class_name NPCTransition extends Area2D
const npc_01 = (preload("uid://fpv6io6nfu42"))

var npc:NPC
var npc_spawned : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_npc_instance()
	await get_tree().create_timer(0.2).timeout
	npc_spawned = true
	set_npc_position(global_position)

func add_npc_instance() -> void:
	npc = npc_01.instantiate()
	add_child(npc)
	
func set_npc_position(_new_pos : Vector2) -> void:
	npc.global_position = _new_pos
