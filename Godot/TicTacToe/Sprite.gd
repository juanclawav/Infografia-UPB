extends Sprite

var player
var boton1
var boton2
var boton3
var boton4
var boton5
var boton6
var boton7
var boton8
var boton9
var boton_restart
var wins =[0,0]
var label_wins
var label_current

signal bt_click(bt_name, player)
signal btr_click(player)
signal new_round(wins)
signal switch_turn(player)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	player = 1
	emit_signal("switch_turn",player)
	boton1 = get_parent().get_node("Button")
	boton1.text=""
	boton2 = get_parent().get_node("Button2")
	boton2.text=""
	boton3 = get_parent().get_node("Button3")
	boton3.text=""
	boton4 = get_parent().get_node("Button4")
	boton4.text=""
	boton5 = get_parent().get_node("Button5")
	boton5.text=""
	boton6 = get_parent().get_node("Button6")
	boton6.text=""
	boton7 = get_parent().get_node("Button7")
	boton7.text=""
	boton8 = get_parent().get_node("Button8")
	boton8.text=""
	boton9 = get_parent().get_node("Button9")
	boton9.text=""
	boton_restart = get_parent().get_node("ButtonRestart")
	boton_restart.visible = not visible
	
func check():
	var won=false
	var end_round = false
	match "X":
		boton1.text:
			if boton1.text==boton2.text && boton2.text==boton3.text or boton1.text==boton5.text && boton5.text==boton9.text or boton1.text==boton4.text && boton4.text==boton7.text:
				won=true
				end_round = true
		boton2.text:
			if boton2.text==boton5.text && boton5.text==boton8.text:
				end_round=true
				won=true
		boton3.text:
			if boton3.text==boton6.text && boton6.text==boton9.text or boton3.text==boton5.text && boton5.text==boton7.text:
				end_round=true
				won=true
		boton4.text: 
			if boton4.text==boton5.text && boton5.text==boton6.text:
				end_round=true
				won=true
		boton7.text: 
			if boton7.text==boton8.text && boton8.text==boton9.text or boton3.text==boton5.text && boton5.text==boton7.text:
				end_round=true
				won=true
		_:
			won=false

	match "O":
		boton1.text:
			if boton1.text==boton2.text && boton2.text==boton3.text or boton1.text==boton5.text && boton5.text==boton9.text or boton1.text==boton4.text && boton4.text==boton7.text:
				won=true
				end_round = true
		boton2.text:
			if boton2.text==boton5.text && boton5.text==boton8.text:
				end_round=true
				won=true
		boton3.text:
			if boton3.text==boton6.text && boton6.text==boton9.text or boton3.text==boton5.text && boton5.text==boton7.text:
				end_round=true
				won=true
		boton4.text: 
			if boton4.text==boton5.text && boton5.text==boton6.text:
				end_round=true
				won=true
		boton7.text: 
			if boton7.text==boton8.text && boton8.text==boton9.text or boton3.text==boton5.text && boton5.text==boton7.text:
				end_round=true
				won=true
		_:
			won=false
	
	if boton1.text!="" and boton2.text!="" and boton3.text!="" and boton4.text!="" and boton5.text!="" and boton6.text!="" and boton7.text!="" and boton8.text!="" and boton9.text!="":
		won = false
		end_round=true
			
	if end_round:
		if !won :
			boton_restart.text="Partida terminada! Empate \n Click en este boton para jugar otra partida"
		else:
			boton_restart.text="Partida terminada! Ganador: Jugador "+str(player)+"\n Click en este boton para jugar otra partida"
			wins[player-1]+=1
		boton_restart.visible = visible
		

func _on_Button_button_up():
	if boton1.text=="":
		emit_signal("bt_click",boton1.name,player)
		check()
		if player==2:
			player=1
		else:
			player=2
		emit_signal("switch_turn",player)



func _on_Button2_button_up():
	if boton2.text=="":
		emit_signal("bt_click",boton2.name,player)
		check()
		if player==2:
			player=1
		else:
			player=2
		emit_signal("switch_turn",player)


func _on_Button3_button_up():
	if boton3.text=="":
		emit_signal("bt_click",boton3.name,player)
		check()
		if player==2:
			player=1
		else:
			player=2
		emit_signal("switch_turn",player)

func _on_Button4_button_up():
	if boton4.text=="":
		emit_signal("bt_click",boton4.name,player)
		check()
		if player==2:
			player=1
		else:
			player=2
		emit_signal("switch_turn",player)

func _on_Button5_button_up():
	if boton5.text=="":
		emit_signal("bt_click",boton5.name,player)
		check()
		if player==2:
			player=1
		else:
			player=2
		emit_signal("switch_turn",player)

func _on_Button6_button_up():
	if boton6.text=="":
		emit_signal("bt_click",boton6.name,player)
		check()
		if player==2:
			player=1
		else:
			player=2
		emit_signal("switch_turn",player)
	
func _on_Button7_button_up():
	if boton7.text=="":
		emit_signal("bt_click",boton7.name,player)
		check()
		if player==2:
			player=1
		else:
			player=2
		emit_signal("switch_turn",player)

func _on_Button8_button_up():
	if boton8.text=="":
		emit_signal("bt_click",boton8.name,player)
		check()
		if player==2:
			player=1
		else:
			player=2
		emit_signal("switch_turn",player)
func _on_Button9_button_up():
	if boton9.text=="":
		emit_signal("bt_click",boton9.name,player)
		check()
		if player==2:
			player=1
		else:
			player=2
		emit_signal("switch_turn",player)

func _on_ButtonRestart_button_up():
	_ready()
	emit_signal("btr_click",player)
	emit_signal("new_round",wins)
