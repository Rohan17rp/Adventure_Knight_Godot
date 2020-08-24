extends KinematicBody2D

export var speed = 400

var screen_size 
var enemy_dead = false
var velocity = Vector2(0, 0)
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	velocity.x = speed * delta * direction
	velocity.y = 0
	var collision = move_and_collide(velocity)
	if collision:
		$AnimatedSprite.scale.x = -1
		direction *= -1
