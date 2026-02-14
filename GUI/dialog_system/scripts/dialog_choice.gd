@tool
@icon("res://imports/npc_and_dialog/icons/question_bubble.svg")
class_name DialogChoice extends DialogItem

var dialog_branches : Array[DialogBranch] = []

func _ready() -> void:
	dialog_branches = []
	for c in get_children():
		if c is DialogBranch:
			dialog_branches.append(c)
	print("DialogChoice branches collected:", dialog_branches.size())	
func _get_configuration_warnings() -> PackedStringArray:
	if _check_for_dialog_branches() == false:
		return ["Requires at least two DialogBranch nodes!"]
	else:
		return []
	pass
	
func _check_for_dialog_branches() -> bool:
	var _count : int = 0
	for c in get_children():
		if c is DialogBranch:
			_count += 1
			if _count > 1:
				print("Your DialogBranch node count is: ", _count)
				return true
				
	return false
	
