extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
var speed = 300

func _physics_process(delta: float) -> void:
	move_and_slide()
func _on_area_2d_body_entered(body):
	if (body.is_in_group("Player")):
		
		#Animation
		animated_sprite_2d.play("movement")
		
		#Movement
		if (body.position.x > position.x):
			velocity.x = speed * -1
		else:
			velocity.x = speed 

func _on_brake_body_entered(body):
	if (body.is_in_group("Player") == false):
		velocity.x = 0

func _on__body_entered(body):
	if (body.is_in_group("Player")):
		animated_sprite_2d.play("!!!")
func _on__body_exited(body):
	if (body.is_in_group("Player")):
		animated_sprite_2d.play("idle")
