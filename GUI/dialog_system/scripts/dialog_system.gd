@tool
@icon("res://imports/npc_and_dialog/icons/star_bubble.svg")
class_name DialogSystemNode extends CanvasLayer

signal finished
signal letter_added(letter:String)

var is_active : bool = false
var text_in_progress : bool = false
var waiting_for_choice : bool = false

var text_speed : float = 0.02
var text_length : int = 0
var plain_text : String 

var dialog_items : Array[DialogItem]
var dialog_item_index : int = 0 # keeps track of dialog progression

@onready var dialog_ui: Control = $DialogUI
@onready var content: RichTextLabel = $DialogUI/PanelContainer/RichTextLabel
@onready var name_label: RichTextLabel = $DialogUI/NameLabel
@onready var portrait_sprite: DialogPortrait = $DialogUI/PortraitSprite
@onready var dialog_progress: PanelContainer = $DialogUI/DialogProgress
@onready var dialog_progress_label: RichTextLabel = $DialogUI/DialogProgress/RichTextLabel
@onready var timer: Timer = $DialogUI/Timer
@onready var audio_stream_player: AudioStreamPlayer = $DialogUI/AudioStreamPlayer
@onready var choice_options: VBoxContainer = $DialogUI/VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		if get_viewport() is Window:
			get_parent().remove_child(self)
			return
		return
	timer.timeout.connect(_on_timer_timeout)
	hide_dialog()
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	if is_active == false:
		return #don't handle input when is_active = false
	if (
			event.is_action_pressed("interact") or
			event.is_action_pressed("ui_accept") or 
			event.is_action_pressed("attack")
	):
		if text_in_progress == true:
			return
		elif waiting_for_choice == true:
			return
		dialog_item_index += 1 #adds to index, furthering dialog
		if dialog_item_index < dialog_items.size():
			start_dialog()
		else:
			hide_dialog()
			
		
func show_dialog(_items:Array[DialogItem]) -> void:
	is_active = true
	dialog_ui.visible = true
	dialog_ui.process_mode = Node.PROCESS_MODE_ALWAYS
	dialog_items = _items
	dialog_item_index = 0 #starts from beginning
	get_tree().paused = true #pauses entire tree
	await get_tree().process_frame #awaits next tick
	start_dialog()
	pass
	
func hide_dialog() -> void:
	is_active = false
	choice_options.visible = false
	dialog_ui.visible = false
	dialog_ui.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = false
	finished.emit()
	
	pass
	
func start_dialog() -> void:
	waiting_for_choice = false
	show_dialog_button_indicator(false)
	var _d : DialogItem = dialog_items[dialog_item_index]
	
	if _d is DialogText:
		set_dialog_text(_d as DialogText)
	elif _d is DialogChoice:
		set_dialog_choice(_d as DialogChoice)
	pass
		
func set_dialog_text(_d : DialogText) -> void:
	if _d is DialogText:
		content.text = _d.text
	name_label.text = _d.npc_info.npc_name
	portrait_sprite.texture = _d.npc_info.portrait
	portrait_sprite.audio_pitch_base = _d.npc_info.dialog_audio_pitch
	choice_options.visible = false
	content.visible_characters = 0
	text_length = content.get_total_character_count()
	plain_text = content.get_parsed_text()
	text_in_progress = true
	start_timer()
	pass
#set dialog choice UI based on parameters
func set_dialog_choice(_d: DialogChoice) -> void:
	choice_options.visible = true
	waiting_for_choice = true
	for c in choice_options.get_children():
		c.queue_free() #removes default UI buttons
	print(_d.dialog_branches.size())	
	for i in _d.dialog_branches.size():
		var _new_choice : Button = Button.new()
		choice_options.add_child(_new_choice)
		_new_choice.text = _d.dialog_branches[i].text
		_new_choice.pressed.connect(_dialog_choice_selected.bind(_d.dialog_branches[i]))
		_new_choice.theme = preload("res://GUI/dialog_system/dialog_choice.tres")
	if Engine.is_editor_hint():
		return
	await get_tree().process_frame #wait one tick
	choice_options.get_child(0).grab_focus()

	
	
	
	
		
	pass
func _dialog_choice_selected(_d : DialogBranch) -> void:
	choice_options.visible = false
	show_dialog(_d.dialog_items)
	
	pass
func show_dialog_button_indicator(_is_visible : bool) -> void:
	dialog_progress.visible = _is_visible
	if dialog_item_index +1  < dialog_items.size():
		dialog_progress_label.text = "NEXT"
	else: #at the last item
		dialog_progress_label.text = "END"
	pass
	
func start_timer() -> void:
	timer.wait_time = text_speed
	#manipulate wait_time
	var _char = plain_text[content.visible_characters - 1]
	if '.?!:;'.contains(_char):
		timer.wait_time *= 4 #pauses for punctuation
	elif ', '.contains(_char):
		timer.wait_time *= 2
		
		
	timer.start()#everytime timer runs out, add another letter
	pass
	
func _on_timer_timeout() -> void:
	#add a character to visible characters
	print("_on_timer_timeout()")
	content.visible_characters += 1
	if content.visible_characters <= text_length:
		letter_added.emit(plain_text[content.visible_characters-1])
		start_timer()
	else:
		show_dialog_button_indicator(true)
		text_in_progress = false
	pass
