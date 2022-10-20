extends Control
func _ready():
	$AudioStreamPlayer.play()
func initialize(status):
	if status == "W":
		$VBoxContainer/Label.text = "Ganaste"
		$VBoxContainer/Button.text = "Jugar de nuevo"
	else:
		$VBoxContainer/Label.text = "Moriste >:("
		$VBoxContainer/Button.text = "Jugar de nuevo"


func _on_Button_pressed():
	var _return = get_tree().change_scene("res://scenes/World.tscn")
	queue_free()
