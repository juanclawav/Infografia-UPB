extends Control
func _ready():
	$AudioStreamPlayer.play()
func initialize(status):
	if status == "W":
		$VBoxContainer/Label.text = "Ganaste"
		$VBoxContainer/Button.text = "Jugar de nuevo"
	else: 
		if status == "W1":
			$VBoxContainer/Label.text = "Ganador: Jugador 1"
			$VBoxContainer/Button2.text = "Jugar de nuevo"
		else:
			if status == "W2":
				$VBoxContainer/Label.text = "Ganador: Jugador 2"
				$VBoxContainer/Button2.text = "Jugar de nuevo"
			else: 
				$VBoxContainer/Label.text = "Moriste >:("
				$VBoxContainer/Button.text = "Jugar de nuevo"


func _on_Button_pressed():
	var _return = get_tree().change_scene("res://scenes/World.tscn")
	queue_free()


func _on_Button2_pressed():
	var _return = get_tree().change_scene("res://scenes/WorldM.tscn")
	queue_free()
