extends Sprite

var angular_speed = 2
var speed = 0
var MAX_SPEED = 650
var MAX_ANGSPEED = 6
var boton_inc_speed
var estado_label

# señales
signal speed_change(new_speed)

func _ready():
	boton_inc_speed = get_parent().get_node("Inc_speed")
	estado_label=get_parent().get_node("velo")
	
	var timer = get_parent().get_node("Timer")
	timer.connect("timeout", self, "_on_timer_timeout")
	
func _on_timer_timeout():
	print("time")
	
func _process(delta):
	# Flechas arriba y abajo, movimiento en direccion de sprite
	var movement = Vector2(0,0)
	if Input.is_action_pressed("ui_down"):
		movement = -Vector2.UP.rotated(rotation)
	if Input.is_action_pressed("ui_up"):
		movement = Vector2.UP.rotated(rotation)
	#Flechas izquierda y derecha, rotacion sobre eje propio
	if Input.is_action_pressed("ui_left"):
		rotation += -0.1*angular_speed
	if Input.is_action_pressed("ui_right"):
		rotation += 0.1*angular_speed
	position += delta * movement * speed
	
	
	#Movimiento circular
	#rotation += delta*angular_speed
	#var velocity = Vector2.UP.rotated(rotation)*speed
	#position += delta*velocity
	
func _on_Inc_speed_button_up():
	speed += 50
	if speed>MAX_SPEED:
		speed= MAX_SPEED
	#estado_label.text=str(speed)
	emit_signal("speed_change",speed)
func _on_Dec_speed_button_up():
	speed -= 50
	if speed<0:
		speed=0
	emit_signal("speed_change",speed)

func _on_Inc_speed2_button_up():
	angular_speed += 0.5
	if angular_speed>MAX_ANGSPEED:
		angular_speed=MAX_ANGSPEED
func _on_Dec_speed2_button_up():
	angular_speed -= 0.5
	if angular_speed<0:
		angular_speed=0

