@tool
extends NPCBehavior

@export var walk_speed : float = 30.0

var patrol_locations : Array[PatrolLocation]
var current_location_index : int = 0
var target : PatrolLocation


func _ready() -> void:
	gather_patrol_locations()
	if Engine.is_editor_hint():
		child_entered_tree.connect(gather_patrol_locations) #everytime a child is added, call function
		child_order_changed.connect(gather_patrol_locations) 
	pass
	super()
	if patrol_locations.size() == 0:
		process_mode = Node.PROCESS_MODE_DISABLED
		return
	target = patrol_locations[0]
	
func gather_patrol_locations(_n : Node = null) -> void:
	patrol_locations = []
	for c in get_children():
		if c is PatrolLocation:
			patrol_locations.append(c)
	pass
func start() -> void:
	if npc.do_behavior == false or patrol_locations.size() < 2:
		return
	#IDLE PHASE
	npc.global_position = target.target_position
	npc.state = "idle"
	npc.velocity = Vector2.ZERO
	npc.update_animation()
	
	var wait_time : float = target.wait_time
	
	pass
