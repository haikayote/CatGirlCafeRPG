class_name State_Idle extends State

@onready var walk : State = $"../Walk"

func _ready(): 
	pass
#what happens when the player enters the state
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
#what happens during the _process update of this state
func Process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
#what happens during the physics process update of this state
func Physics(_delta : float) -> State:
	return null
	
#what happens with input events in this state
func HandleInput(_event : InputEvent) -> State:
	return null
