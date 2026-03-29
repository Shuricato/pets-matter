extends Node2D

var Cat = preload("res://Assets/Animals/Cat/Cat.tscn")
var Dog = preload("res://Assets/Animals/Dog/Dog.tscn")
var Bird = preload("res://Assets/Animals/Bird/Bird.tscn")
var new_dog
var spawned: bool = false
@onready var shelf_1 = $ItemShelf
@onready var shelf_2 = $ItemShelf2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DialogueButton.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Panel/Panel2/Score.text = "Score: " + str(score)

var score: int = 0

func add_score(points: int) -> void:
	score += points

func reset_score() -> void:
	score = 0

func _on_door_pressed() -> void:
	var animal = randi_range(0,2)
	if !spawned:
		spawned = true
		match animal:
			0:
				_on_dog_pressed()
			1:
				_on_cat_pressed()
			2:
				_on_parrot_pressed()

func _on_cured() -> void:
	spawned = false

func _on_dog_pressed() -> void:
	new_dog = Dog.instantiate()
	add_child(new_dog)
	new_dog.cured.connect(_on_cured)
	
	new_dog.position = Vector2(510, 315)
	new_dog.z_index = 2
	new_dog.scale = Vector2(0.4,0.4)

func _on_parrot_pressed() -> void:
	new_dog = Bird.instantiate()
	add_child(new_dog)
	new_dog.cured.connect(_on_cured)
	
	new_dog.position = Vector2(550, 425)
	new_dog.z_index = 2
	new_dog.scale = Vector2(0.4,0.4)

func _on_cat_pressed() -> void:
	new_dog = Cat.instantiate()
	add_child(new_dog)
	new_dog.cured.connect(_on_cured)
	
	new_dog.position = Vector2(530, 375)
	new_dog.z_index = 2
	new_dog.scale = Vector2(0.4,0.4)

func _on_swap_button_pressed() -> void:
	$SwapButton/SwapTexture.flip_h = !$SwapButton/SwapTexture.flip_h
	if shelf_1.visible == true:
		shelf_2.visible = true
		shelf_1.visible = false
	else:
		shelf_1.visible = true
		shelf_2.visible = false

func _on_bandage_pressed() -> void:
	if new_dog:
		if (new_dog._remove_injury("abrasion") or new_dog._remove_injury("paw")):
			score = score +100
		else:
			score = score -100

func _on_pliers_pressed() -> void:
	if new_dog:
		if new_dog._remove_injury("tooth"):
			score = score +100
		else:
			score = score -100

func _on_eye_drops_pressed() -> void:
	if new_dog:
		if new_dog._remove_injury("eye"):
			score = score +100
		else:
			score = score -100

func _on_ear_drops_pressed() -> void:
	if new_dog:
		if new_dog._remove_injury("ear"):
			score = score +100
		else:
			score = score -100

func _on_corn_starch_pressed() -> void:
	if new_dog:
		if new_dog._remove_injury("pin feather"):
			score = score +100
		else:
			score = score -100

func _on_forceps_pressed() -> void:
	if new_dog:
		if new_dog._remove_injury("ingestion"):
			score = score +100
		else:
			score = score -100

func _on_diet_pressed() -> void:
	if new_dog:
		if new_dog._remove_injury("fat"):
			score = score +100
		else:
			score = score -100

func _on_clippers_pressed() -> void:
	if new_dog:
		if (new_dog._remove_injury("claws") or new_dog._remove_injury("beak")):
			score = score +100
		else:
			score = score -100

func _on_swap_mouse_entered(button_p) -> void:
	$SwapButton/SwapTexture.modulate = Color(1.2, 1.2, 1.2)

func _on_swap_mouse_exited() -> void:
	$SwapButton/SwapTexture.modulate = Color(1, 1, 1)

func _on_door_mouse_entered() -> void:
	var open = load("res://Assets/Office items/Door_open.tres")
	$Door/DoorTexture.texture = open

func _on_door_mouse_exited() -> void:
	var closed = load("res://Assets/Office items/Door_closed.tres")
	$Door/DoorTexture.texture = closed
