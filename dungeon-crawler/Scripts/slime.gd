extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D = null
@onready var animations = $AnimationPlayer
var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = endPoint.global_position

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
func updateAnimation():
	var animationString 
	if velocity.length() > 0:
		animationString = "Slime-Jump"
	else:
		animationString = "Slime-Idle"
	
	animations.play(animationString)
	
func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
		
	velocity = moveDirection.normalized()*speed

func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
		


func _on_hurt_box_area_entered(area):
	if area == $hitBox: return
	queue_free()
	pass # Replace with function body.
