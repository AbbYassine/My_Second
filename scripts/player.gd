extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -700.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const wallJumpGravity = 300
const wallJumpVelocity = 1000



func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	# Add the gravity.
	if not is_on_floor() :
		if is_on_wall() and velocity.y > 0:
			velocity.y += wallJumpGravity * delta
		else :
			velocity  += get_gravity() * delta

	# Handle jump and wall jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("jump") and is_on_wall():
		velocity.y = JUMP_VELOCITY
		velocity.x = wallJumpVelocity * get_wall_normal().x
		wallJumpDirection(direction)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 30)
	
	#handle animation
	if is_on_floor():
		if direction == 0 :
			animated_sprite_2d.play("idle")
		elif direction :
			animated_sprite_2d.play("run")
	else :
		animated_sprite_2d.play("jump")
		
	move_and_slide()
	# handle the direction the sprite is looking 
	if direction == 1:
		animated_sprite_2d.flip_h = false
	if direction == -1:
		animated_sprite_2d.flip_h = true
	

	# handle the direction the sprite is looking when wall jumping
func wallJumpDirection( direction ):
	if direction == 1:
		animated_sprite_2d.flip_h = false
	if direction == -1:
		animated_sprite_2d.flip_h = true
