extends CharacterBody2D


const SPEED = 150
const JUMP_VELOCITY = -200.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Input direction
	var direction := Input.get_axis("go_left", "go_right")
	
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
		animated_sprite.play("FALLING_JUMP")
	# Aplly movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
