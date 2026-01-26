@tool
class_name NPC extends CharacterBody2D

signal do_behavior_enabled

var state : String = "idle"
var direction : Vector2 = Vector2.DOWN
var direction_name : String = "down"

@export var npc_resource : NPCResource : set = _set_npc_resource
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation : AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_npc()
	if Engine.is_editor_hint():
		return
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	move_and_slide()

func update_animation() -> void:
	animation.play(state + "_" + direction_name)
func setup_npc() -> void:
	if npc_resource:
		if sprite:
			sprite.texture = npc_resource.sprite
		

		 
	pass

func _set_npc_resource(_npc:NPCResource) -> void:
	npc_resource = _npc
	setup_npc()
	pass
	
	
