extends KinematicBody2D

var velocity = Vector2()
var gravity = 20
var jump = 700
var walkspeed = 300
var friction = 20
var is_jumping = false

func _ready():
	$audio_jump.stream.loop = false	
	pass # Replace with function body.


func _process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta):
	velocity.y += gravity
	velocity.x -= friction * (1 if velocity.x > 0 else -1)
	
	if abs(velocity.x) <= friction:
		velocity.x = 0
	
	velocity  = move_and_slide(velocity, Vector2.UP)
	
	if abs(velocity.x) <= friction:
		velocity.x = 0
		$AnimatedSprite.frame = 3
		$audio.stop()
	
		
	$AnimatedSprite.playing = velocity.x != 0

	
	
	
	if abs(velocity.x) > 0 and is_on_floor():
		if !$audio.is_playing():
			$audio.play()
	
	if !is_on_floor():
		$audio.stop()
		$AnimatedSprite.playing = false
		$AnimatedSprite.frame = 0
	
	if is_on_floor():
		if Input.is_action_pressed("ui_jump"):
			
			$audio_jump.play()			
			
			velocity.y = jump * -1
	
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite.flip_h = true
		velocity.x = - walkspeed

	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.flip_h = false
		velocity.x = walkspeed

	

