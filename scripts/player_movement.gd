extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	set_accel(Vector2(0,10))
var accel = Vector2(0,10) setget set_accel,get_accel
func set_accel(val):
	accel = val
	jump_dir = accel.normalized()*-1
func get_accel():
	return accel
var jump_height = 400
var jump_dir : Vector2
var velocity : Vector2 = Vector2(0,0) setget set_val,get_val
func set_val(val):
	velocity = val
func get_val():
	return velocity
var movement_speed = 800
var on_ground = true setget set_on_ground,get_on_ground
func set_on_ground(val):
	on_ground = val
	if (val == true):
		can_jump = true
func get_on_ground():
	return on_ground
var can_jump = true setget set_can_jump, get_can_jump
func set_can_jump(val):
	can_jump = val
	if (can_jump):
		$Timer.start()
func get_can_jump():
	return can_jump
var last_norm : Vector2
#takes the direction of accelleration and returns the direction that the player wants to move
func get_dir(accel,speed):
	var dir_vector = accel.normalized().rotated(PI/2)
	#-1 if left, 1 if right, 0 if neither or both
	var move_dir = (1*int(Input.is_action_pressed("move_left"))+-1*int(Input.is_action_pressed("move_right")))
	return dir_vector * move_dir * speed
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = move_and_collide((get_dir(accel,movement_speed)+velocity)*delta)
	if collision:
		last_norm = collision.normal
		var angle_to_col = collision.normal.angle_to_point(accel.normalized())
		if angle_to_col > PI:
			angle_to_col -= PI
		print(str(angle_to_col))
		if  angle_to_col < PI/16:
			set_on_ground(true)
		set_can_jump(true)
		velocity = Vector2(0,0)
	
	if (Input.is_action_just_pressed("Jump") and can_jump):
		print("jumping!")
		velocity = jump_dir*jump_height
		set_can_jump(false)
		set_on_ground(false)
	
	velocity += accel


func _on_Timer_timeout():
	can_jump = false
		
