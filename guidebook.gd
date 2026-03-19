extends Control

@onready var anim = $AnimationPlayer

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_texture_button_pressed():
	is_open = !is_open
	if is_open:
		anim.play("slide_in")
	else:
		anim.play_backwards("slide_in")
