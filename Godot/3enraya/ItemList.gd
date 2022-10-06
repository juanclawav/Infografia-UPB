extends ItemList

func _ready():
	visible = visible
	
func _on_Main_bt_click(bt_name, player):
	if player ==1:
		get_node(bt_name).text = "X"
	if player ==2:
		get_node(bt_name).text = "O"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
