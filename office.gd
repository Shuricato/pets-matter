extends Node2D

class Animal:
	var id
	var injuries: Array = []

	func _init() -> void:
		#Possible max of 3 injuries per animal
		var injury_count = randi_range(1,3)
		for i in injury_count:
			#4 possible types of injuries, no duplicates
			var injury_id = randi_range(0,3)
			if !injuries.has(injury_id):
				injuries.append(injury_id)
var animal = Animal.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_texture_button_pressed() -> void:
	if animal.injuries.has(0):
		print("Correct treatment")
