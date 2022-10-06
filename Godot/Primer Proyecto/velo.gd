extends Label

func _on_Sprite_speed_change(new_speed):
	text = "Speed: "+str(+new_speed)
