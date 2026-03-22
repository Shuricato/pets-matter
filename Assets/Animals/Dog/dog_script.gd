extends Sprite2D

var injuries: Array = []
var injured: bool = false
var injuredSprite = preload("res://Assets/Animals/Dog/Dog_injured.tres")
var healthySprite = preload("res://Assets/Animals/Dog/Dog.tres")

@export var injury_overlay_nodes: Array[NodePath] = []  # Child Sprite2Ds for overlays

var conditions: Dictionary = {
	"tooth": 4,
	"ear": 1,
	"eye": 2,
	"abrasion": 3,
	"paw": 0
}

func _ready() -> void:
	_generate_injuries()
	_update_visuals()

func _generate_injuries() -> void:
	injuries.clear()
	var injury_count = randi_range(1, 5)
	while injuries.size() < injury_count:
		var injury_id = randi_range(0, 4)
		if !injuries.has(injury_id):
			injuries.append(injury_id)
	injured = true

#TRUE: Success at removal, FALSE: You fucked up
func _remove_injury(condition_name: String) -> bool:
	var injury_id
	if conditions.has(condition_name):
		injury_id = conditions[condition_name]
	else:
		injury_id = 5
	if (injuries.has(injury_id)):
		injuries.erase(injury_id)
		if (injuries.is_empty()):
			injured = false
		_update_visuals()
		return true
	return false

func _update_visuals() -> void:
	for i in injury_overlay_nodes.size():
		var overlay = get_node(injury_overlay_nodes[i]) as Sprite2D
		if overlay:
			overlay.visible = injuries.has(i)
	if (injured):
		texture = injuredSprite
	else: 
		texture = healthySprite
		await get_tree().create_timer(4).timeout
		_set_no_animal()

func _set_no_animal() -> void:
	self.queue_free()
