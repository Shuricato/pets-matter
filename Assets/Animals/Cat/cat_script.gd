extends Sprite2D

var injuries: Array = []
var injured: bool = false
var injuredSprite = preload("res://Assets/Animals/Cat/Cat_injured.tres")
var healthySprite = preload("res://Assets/Animals/Cat/Cat.tres")

@export var injury_overlay_nodes: Array[NodePath] = []  # Child Sprite2Ds for overlays
@export var obesity_id: int
@export var fb_ingestion_id: int
@export var tooth_fracture_id: int

func _ready() -> void:
	_generate_injuries()
	_update_visuals()

func _generate_injuries() -> void:
	injuries.clear()
	var injury_count = randi_range(1, 5)
	var pool = range(0, 5)
	
	if randi_range(0, 1) == 1:
		injuries.append(obesity_id)
		injured = true
		return

	pool.erase(obesity_id)
	if randi_range(0, 1) == 1:
		pool.erase(fb_ingestion_id)
	else:
		pool.erase(tooth_fracture_id)
	
	pool.shuffle()
	injury_count = mini(injury_count, pool.size())
	for i in injury_count:
		injuries.append(pool[i])
	injured = true
	print(injuries.size())
	
#TRUE: Success at removal, FALSE: You fucked up
func _remove_injury(injury_id: int) -> bool:
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

func _set_no_animal() -> void:
	self.queue_free()
