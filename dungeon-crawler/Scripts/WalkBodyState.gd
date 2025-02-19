class_name WalkBodyState
extends State

# get player body node and set it to variable player
# root node has been assigned in the editor
@export var player: CharacterBody2D
var lastPlayerDirection := ""

func Enter():
	# calls which animation that needs to be played
	# this signal is connected in the player controller script
	# the player controller reads this signal and a match statement plays the associated animation
	body_animation_changed.emit("Walk")
	
	lastPlayerDirection = player.cardinalDirection


func Physics_update(_delta):
	# checks if direction has changed, updates animation if it has
	body_animation_changed.emit("Walk") # NOTE this is constantly emitting to update animation direction, could work better


	player.velocity = -player.inputDirectionVector.normalized() * player.moveSpeed

	if player.isTouchingDoor:
		pass # room change emit here
	elif player.inputDirectionVector.length() == 0:
		transitioned.emit("IdleBodyState")
