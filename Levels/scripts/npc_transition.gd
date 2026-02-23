class_name NPCTransition extends Area2D
const npc_01 = (preload("uid://fpv6io6nfu42"))

var npc:NPC
var npc_spawned : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_npc()

func spawn_npc() -> void:
	if npc_spawned:
		return
		
	npc = npc_01.instantiate()
	add_child(npc)
	npc.global_position = global_position
	
	npc.interaction_finished.connect(_on_npc_finished)  #connect signal
	
	npc_spawned = true
	
func _on_npc_finished() -> void:
	npc.queue_free()
	npc_spawned = false
	
	await get_tree().create_timer(0.5).timeout
	spawn_npc()
