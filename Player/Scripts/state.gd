class_name State extends Node

static var player : Player

func _ready(): 
	pass
#what happens when the player enters the state
func Enter() -> void:
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
#what happens during the _process update of this state
func Process(_delta: float) -> State:
	return null
#what happens during the physics process update of this state
func Physics(_delta : float) -> State:
	return null
	
#what happens with input events in this state
func HandleInput(_event : InputEvent) -> State:
	return null
