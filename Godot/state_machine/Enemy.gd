extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 100
var acc = 4

onready var statemachine = $AnimationTree.get("parameters/playback")
onready var timer = $Timer

func _on_Timer_timeout():
	var duration = rand_range(3,7)
	statemachine.travel("attack")
	timer.start(duration)
	
