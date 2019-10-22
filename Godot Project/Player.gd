extends KinematicBody2D

export(String, FILE, ".txt") var YMAX

const GRAVITY = 20
const MAX_SPEED = 250
const ACCELERATION = 60
const JUMP_HEIGHT = -600
const UP = Vector2(0, -1)
var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friction = true
		
	if is_on_floor() and Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		if $Walk.playing == false:
			$Walk.play()
	else:
		$Walk.stop()
	
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction:
			motion.x = lerp(motion.x, 0, 0.2)
			
	else:
		if motion.x < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		if friction:
			motion.x = lerp(motion.x, 0, 0.5)
		
		if $Walk.playing:
			$Walk.stop()
	
	motion = move_and_slide(motion, UP)
	
	if position.y > float(YMAX):
		position.x = 0
		position.y = 0
		motion.x = 0
		motion.y = 0
		
		$Fail.play()
		

