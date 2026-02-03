@tool
@icon("res://imports/npc_and_dialog/icons/star_bubble.svg")
class_name DialogSystemNode extends CanvasLayer


var is_active : bool = false

@onready var dialog_ui: Control = $DialogUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		if get_viewport() is Window:
			get_parent().remove_child(self)
			return
		return
	hide_dialog()
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	#if is_active == false:
		#return #don't handle input when is_active = false
	if event.is_action_pressed("test"):
		if is_active == false:
			show_dialog()
		else: 
			hide_dialog()
		
func show_dialog() -> void:
	is_active = true
	dialog_ui.visible = true
	dialog_ui.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true #pauses entire tree
	pass
	
func hide_dialog() -> void:
	is_active = false
	dialog_ui.visible = false
	dialog_ui.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = false
	
	pass
	
