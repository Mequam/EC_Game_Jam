extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	set_val(Vector2(0,1))
var accel = Vector2(0,10)
var jump_height = 400
var jump_dir : Vector2
var velocity : Vector2 = Vector2(0,0) setget set_val,get_val
func set_val(val):
	velocity = val
	jump_dir = velocity.normalized()*-1
func get_val():
	return velocity
var movement_speed = 800
var col = true

#takes the direction of accelleration and returns the direction that the player wants to move
func get_dir(accel,speed):
	var dir_vector = accel.normalized().rotated(PI/2)
	#-1 if left, 1 if right, 0 if neither or both
	var move_dir = (1*int(Input.is_action_pressed("move_left"))+-1*int(Input.is_action_pressed("move_right")))
	return dir_vector * move_dir * speed
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("Jump")):
		print("jumping")
		velocity = jump_dir*jump_height
		col = false
	if (!col):
		velocity += accel
	else:
		velocity = Vector2(0,0)
	var collision = move_and_collide((get_dir(accel,movement_speed)+velocity)*delta)
	col = collision != null
