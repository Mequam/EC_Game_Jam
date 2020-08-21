extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var last_vel : Vector2
var last_pos : Vector2
var unstability = 0
var heat = 0

func get_stabil(unstability,heat,accel_scalar):
	print(str(sqrt(abs(accel_scalar))))
	return unstability - int(sqrt(abs(accel_scalar)) >= 100)*2 - int(abs(heat) >= 2)*1

func get_accel(last_vel,vel,delta):
	return (vel-last_vel)/(delta*10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var parpos = get_parent().position
	var pv = (parpos-last_pos)/(delta*10)
	unstability = get_stabil(
		unstability,
		heat,
		get_accel(last_vel,pv,delta).distance_to(Vector2(0,0))
	)
	last_vel = pv
	last_pos = parpos
