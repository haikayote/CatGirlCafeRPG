@tool
@icon("res://imports/npc_and_dialog/icons/chat_bubbles.svg")
class_name DialogInteraction extends Area2D

signal player_interacted
signal finished

@export var enabled : bool = true

var dialog_items : Array[DialogItem]

@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	monitoring = true	
	enabled = true
	body_entered.connect(_on_area_enter)
	body_exited.connect(_on_area_exit)
	
	for c in dialog_items:
		if c is DialogItem:
			dialog_items.append(c)
	pass

func player_interact() -> void:
	player_interacted.emit()
	DialogSystem.show_dialog()
	
	pass
func _on_area_enter(_a : Node2D) -> void:
	print("player entered!!")
	animation_player.play("show")
	GlobalPlayerManager.interact_pressed.connect(player_interact)
	pass
	
func _on_area_exit(_a: Node2D) -> void:
	print("player exited!!")
	animation_player.play("hide")
	GlobalPlayerManager.interact_pressed.disconnect(player_interact)
	pass
	
	
func _get_configuration_warnings() -> PackedStringArray:
	
	#check for dialog
	if _check_for_dialog_items() == false:
		return [ "Requires at least one DialogItem node."]
	else: 
		return []
	pass
	
func _check_for_dialog_items() -> bool:
	for c in get_children():
		if c is DialogItem:
			return true
	return false
	
