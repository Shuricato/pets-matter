extends Node2D

var Cat = preload("res://Assets/Animals/Cat/Cat.tscn")
var Dog = preload("res://Assets/Animals/Dog/Dog.tscn")
var Bird = preload("res://Assets/Animals/Bird/Bird.tscn")
var new_dog
@onready var shelf_1 = $ItemShelf
@onready var shelf_2 = $ItemShelf2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_dog_pressed() -> void:
	new_dog = Dog.instantiate()
	add_child(new_dog)
	
	new_dog.position = Vector2(510, 300)
	new_dog.z_index = 2
	new_dog.scale = Vector2(0.4,0.4)

func _on_parrot_pressed() -> void:
	new_dog = Bird.instantiate()
	add_child(new_dog)
	
	new_dog.position = Vector2(550, 425)
	new_dog.z_index = 2
	new_dog.scale = Vector2(0.4,0.4)

func _on_cat_pressed() -> void:
	new_dog = Cat.instantiate()
	add_child(new_dog)
	
	new_dog.position = Vector2(530, 375)
	new_dog.z_index = 2
	new_dog.scale = Vector2(0.4,0.4)

func _on_swap_button_pressed() -> void:
	if shelf_1.visible == true:
		shelf_2.visible = true
		shelf_1.visible = false
	else:
		shelf_1.visible = true
		shelf_2.visible = false

func _on_bandage_pressed() -> void:
	new_dog._remove_injury("abrasion")
	new_dog._remove_injury("paw")

func _on_pliers_pressed() -> void:
	new_dog._remove_injury("tooth")

func _on_eye_drops_pressed() -> void:
	new_dog._remove_injury("eye")

func _on_ear_drops_pressed() -> void:
	new_dog._remove_injury("ear")

func _on_corn_starch_pressed() -> void:
	new_dog._remove_injury("pin feather")

func _on_forceps_pressed() -> void:
	new_dog._remove_injury("ingestion")

func _on_diet_pressed() -> void:
	new_dog._remove_injury("fat")

func _on_clippers_pressed() -> void:
	new_dog._remove_injury("claws")
	new_dog._remove_injury("beak")
