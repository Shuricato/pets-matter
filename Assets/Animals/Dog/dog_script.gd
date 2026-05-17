extends Sprite2D

var injuries: Array = []
var injured: bool = false
var injuredSprite = preload("res://Assets/Animals/Dog/Dog_injured.tres")
var healthySprite = preload("res://Assets/Animals/Dog/Dog.tres")
var heartParticle = preload("res://heart_particle.tscn")

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
		spawn_particles_at(injury_id)
		injuries.erase(injury_id)
		if (injuries.is_empty()):
			injured = false
		_update_visuals()
		return true
	return false
	
# Assume you have an array of Sprite2D nodes
var sprites: Array[Sprite2D] = []

func spawn_particles_at(index: int) -> void:
	print("Particles")
	if index < 0 or index > 4:
		return
	
	var sprite  = get_node(injury_overlay_nodes[index]) as Sprite2D
	var particles = heartParticle.instantiate()

	# Add to the scene (as child of current node, or use get_tree().root)
	add_child(particles)

	# Set position to match the sprite
	particles.global_position = sprite.global_position

	particles.lifetime = 1.3
	
	# Auto-clean up after particles finish
	await get_tree().create_timer(particles.lifetime + 0.1).timeout
	particles.queue_free()
	
func spawn_particles_at_head() -> void:
	var sprite  = find_child("Head position")
	var particles = heartParticle.instantiate()
	particles.process_material = particles.process_material.duplicate()

	# Add to the scene (as child of current node, or use get_tree().root)
	add_child(particles)

	# Set position to match the sprite
	particles.global_position = sprite.global_position
	particles.process_material.scale_max = 0.22
	particles.process_material.scale_min = 0.20
	particles.process_material.spread = 70
	particles.amount = 8
	particles.process_material.initial_velocity_min = 140
	particles.process_material.initial_velocity_max = 150
	particles.lifetime = 3
	
	# Auto-clean up after particles finish
	await get_tree().create_timer(particles.lifetime + 0.1).timeout
	particles.queue_free()

func _update_visuals() -> void:
	for i in injury_overlay_nodes.size():
		var overlay = get_node(injury_overlay_nodes[i]) as Sprite2D
		if overlay:
			overlay.visible = injuries.has(i)
	if (injured):
		texture = injuredSprite
	else: 
		spawn_particles_at_head()
		texture = healthySprite
		await get_tree().create_timer(4).timeout
		_set_no_animal()

signal cured
func _set_no_animal() -> void:
	cured.emit()
	self.queue_free()
