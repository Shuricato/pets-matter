extends Node2D

var Cat = preload("res://Assets/Animals/Cat/Cat.tscn")
var new_dog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_dog_pressed() -> void:
	new_dog = Cat.instantiate()
	add_child(new_dog)
	
	new_dog.position = Vector2(510, 300)
	new_dog.z_index = 2
	new_dog.scale = Vector2(0.4,0.4)

func _on_treat_pressed() -> void:
	print("Remove pressed")
	var response = new_dog._remove_injury(0)
	print(response)

func _on_ear_pressed() -> void:
	print("Remove pressed")
	var response = new_dog._remove_injury(1)
	print(response)

func _on_eye_pressed() -> void:
	print("Remove pressed")
	var response = new_dog._remove_injury(2)
	print(response)

func _on_abrasion_pressed() -> void:
	print("Remove pressed")
	var response = new_dog._remove_injury(3)
	print(response)

func _on_swap_button_pressed() -> void:
	pass # Replace with function body.
