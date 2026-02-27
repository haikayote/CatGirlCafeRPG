class_name NPCTransition extends Area2D

@export var day_ending : PackedScene #initialized in the editor
@export var npc_scenes : Array[PackedScene]
@export var day_endings : Array[PackedScene]

var current_index : int = 0
var current_day_index : int = 0
var current_npc : NPC = null
var current_day : Node = null
var day_over : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if day_over: #prevents npc from spawning again
		return
	spawn_next_npc()
func spawn_next_npc() -> void:
	# If no more NPCs, end the day
	if current_index >= npc_scenes.size():
		end_day()
		return

	# Instantiate next NPC
	current_npc = npc_scenes[current_index].instantiate()
	add_child(current_npc)
	current_npc.global_position = global_position

	# Connect signal
	current_npc.interaction_finished.connect(_on_npc_finished)

	
func _on_npc_finished() -> void:
	print("NPC FINISHED called, index:", current_index)
	if day_over:
		return

	# Remove current NPC
	current_npc.queue_free()
	current_npc = null

	# Move to next NPC
	current_index += 1

	# Small delay for pacing
	await get_tree().create_timer(0.5).timeout

	spawn_next_npc()


func end_day() -> void:
	if day_over:
		return
	day_over = true
	print("It's time to pack up for the day...")
	# show dialog
	var end_scene_instance : Node = day_ending.instantiate()
	get_tree().current_scene.add_child(end_scene_instance)
	# change scene back to bedroom
	# increment day counter
	current_day_index += 1
