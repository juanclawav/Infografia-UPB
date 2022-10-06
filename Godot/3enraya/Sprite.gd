extends Sprite

var table
var player = 1
var bt_name
signal bt_click(bt_name, player)

# Called when the node enters the scene tree for the first time.
func _ready():
	table = get_parent().get_node("ItemList")




func _on_ItemList_item_activated(index):
	bt_name = get_parent().get_node("ItemList").get_child(index).name
	emit_signal("bt_click",bt_name,player)
	if player==2:
		player=1
	if player==1:
		player=2
