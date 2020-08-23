extends KinematicBody2D

var state_machine
export var run_speed_max = 150
var run_speed
export var jump_force_max = -500
var jump_force = 0
export var gravity = 450

#func get_input():

  
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	input(delta)
	var velocity = Vector2(run_speed, jump_force)
	var jump = Vector2.UP
	velocity = move_and_slide(velocity, jump)

func input(delta):
	var current = state_machine.get_current_node()
	run_speed = 0
	if Input.is_action_pressed("attack") && current != "jump":
		state_machine.travel("attack")
		return
	if Input.is_action_pressed("ui_right"):
		run_speed = run_speed_max
		$Sprite.scale.x = 1
	if Input.is_action_pressed("ui_left"):
		run_speed = - run_speed_max
		$Sprite.scale.x = -1
	if Input.is_action_just_pressed("ui_up") && current != "jump":
		jump_force = jump_force_max
	if Input.is_action_pressed("ui_down"):
		pass
	
	if run_speed == 0 && jump_force >= 0:
		state_machine.travel("idle")
	if run_speed != 0:
		state_machine.travel("walk")
	if jump_force < gravity:
		state_machine.travel("jump")
		jump_force += 2 * gravity * delta
		
func hurt():
	state_machine.travel("hurt")
func die():
	state_machine.travel("die")

