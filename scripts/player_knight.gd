extends CharacterBody2D


var is_dead = false
@export var walk_speed = 150
@export var run_speed = 250
var speed
const jump_force = -350.0
@export_range(0,1) var jump_deceleration = 0.5


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if (is_dead == false):
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_force
			
		# Jump deceleration
		if Input.is_action_just_released("jump") and velocity.y < 0:
			velocity.y *= jump_deceleration
			
		# Input direction
		var direction := Input.get_axis("go_left", "go_right")
		
		# Run movement
		if Input.is_action_pressed("run"):
			speed = run_speed
		else:
			speed = walk_speed
	
	# Aplly movement
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			
			# flip sprite
		if direction < 0:
			animated_sprite.flip_h = true
		elif direction > 0:
			animated_sprite.flip_h = false
	
		#add animations
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("IDLE")
			else:
				animated_sprite.play("RUNNING")
		else:
			animated_sprite.play("IDLE")
		
	move_and_slide()
	
func die():
		is_dead = true
		velocity.x = 0
		animated_sprite.play("HIT") #temporary
		
func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "HIT":
		animated_sprite.play("DEATH")
