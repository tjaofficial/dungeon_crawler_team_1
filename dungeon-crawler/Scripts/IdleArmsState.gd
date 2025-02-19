class_name IdleArmsState
extends State

# get player body node and set it to variable player
# root node has been assigned in the editor
@export var player: CharacterBody2D
var lastPlayerDirection := ""

func Enter():
	# calls which animation that needs to be played
	# this signal is connected in the player controller script
	# the player controller reads this signal and a match statement plays the associated animation
	arms_animation_changed.emit("Idle")
	
	lastPlayerDirection = player.cardinalDirection


func Physics_update(_delta):
	# checks if direction has changed, updates animation if it has
	if player.cardinalDirection != lastPlayerDirection:
		arms_animation_changed.emit("Idle")
	#
	# 
	# HERE IS WHERE ALL LOGIC PERTAINING TO IDLE STATE GOES
	#
	#
	pass

	if player.isTouchingDoor:
		pass # room change emit here
	elif Input.is_action_just_pressed("left_click"):
		transitioned.emit("AttackArmsState")
	elif player.inputDirectionVector.length() > 0:
		transitioned.emit("WalkArmsState")
