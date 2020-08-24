extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_KinematicBody2D_attack_signal():
	$enemy1.hide() # Replace with function body.


func _on_KinematicBody2D_attack():
	
	$HUD/score.text = "HEALTH : " + "10"# Replace with function body.
