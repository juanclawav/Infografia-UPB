extends Button
func _on_Sprite_bt_click(bt_name, player):
	if player==1 && bt_name==name:
		text = "X"
	if player==2 && bt_name==name:
		text = "O"
