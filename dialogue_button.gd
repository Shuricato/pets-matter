extends Control

@export var dialogue: Array = []
var dialogue_id = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$DialogueButton/DialogueBox/Panel2/RichTextLabel.text = dialogue[dialogue_id]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func next() -> void:
	dialogue_id += 1
	if dialogue_id < dialogue.size():
		$DialogueButton/DialogueBox/Panel2/RichTextLabel.text = dialogue[dialogue_id]
	else:
		self.queue_free()

func _on_pressed() -> void:
	print("PRessed")
	next()
