extends KinematicBody2D

var state_machine
export var run_speed = 80
export var jump_force = 100
export var gravity = 100

#func get_input():

  
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
#	get_input()
	var current = state_machine.get_current_node()
	run_speed = 0
	
	if Input.is_action_pressed("attack"):
		state_machine.travel("attack")
		return
	if Input.is_action_pressed("ui_right"):
		run_speed = 80
		$Sprite.scale.x = 1
	if Input.is_action_pressed("ui_left"):
		run_speed = - 80
		$Sprite.scale.x = -1
	if Input.is_action_just_pressed("ui_up"):
		if(jump_force >= 0):
			jump_force = -100
	if Input.is_action_pressed("ui_down"):
		pass
	
	if run_speed == 0 && jump_force >= 0:
		state_machine.travel("idle")
	if run_speed != 0:
		state_machine.travel("walk")
	if jump_force < 1:
		state_machine.travel("jump")
		jump_force += gravity * delta
	var velocity = Vector2(run_speed, jump_force)
	var jump = Vector2.UP
	velocity = move_and_slide(velocity, jump)
	
func hurt():
	state_machine.travel("hurt")
func die():
	state_machine.travel("die")

