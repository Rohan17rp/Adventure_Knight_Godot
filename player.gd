extends KinematicBody2D

var state_machine
export var run_speed_max = 150
export var jump_force_max = -750
export var gravity = 1200
var is_jump = !is_on_floor()
var velocity = Vector2(0, 0) 

#func get_input():

  
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	input()
	velocity.y += delta * gravity
	velocity = Vector2(velocity.x, velocity.y)
	velocity = move_and_slide(velocity, Vector2(0, -1))

func input():
	var _current = state_machine.get_current_node()
	is_jump = !is_on_floor()
	velocity.x = 0
	if Input.is_action_pressed("attack"):
		state_machine.travel("attack")
		return
	if Input.is_action_pressed("ui_right"):
		velocity.x = run_speed_max
		$Sprite.scale.x = 2
	if Input.is_action_pressed("ui_left"):
		velocity.x = -run_speed_max
		$Sprite.scale.x = -2
	if Input.is_action_pressed("ui_up") && !is_jump:
		velocity.y = jump_force_max
	if Input.is_action_pressed("ui_down"):
		pass
	
	if velocity.x == 0 && !is_jump:
		state_machine.travel("idle")
	if velocity.x != 0 && !is_jump:
		state_machine.travel("walk")
	if is_jump:
		state_machine.travel("jump")
	
func hurt():
	state_machine.travel("hurt")
func die():
	state_machine.travel("die")
