class_name AttackArmsState
extends State

# get player body node and set it to variable player
# root node has been assigned in the editor
@export var player: CharacterBody2D
var lastPlayerDirection := ""

func Enter():
	# calls which animation that needs to be played
	# this signal is connected in the player controller script
	# the player controller reads this signal and a match statement plays the associated animation
	arms_animation_changed.emit("Attack")
	# prints state entry to output panel
	print("Entered Attack Arms")
	
	lastPlayerDirection = player.cardinalDirection


func Physics_update(_delta):
	# checks if direction has changed, updates animation if it has
	if player.cardinalDirection != lastPlayerDirection:
		body_animation_changed.emit("Attack")
	#
	# 
	# HERE IS WHERE ALL LOGIC PERTAINING TO IDLE STATE GOES
	#
	#
	pass

# This is where logic for switching states goes
# should be formatted as if/elif conditionals reading variables from player controller
# NOTE: should have conditionals for all states that can be transitioned to from this state other than itself
#  example below:

		# if player.direction == 0:
		# 	transitioned.emit("IdleArmsState")
		# if player.direction != 0:
		# 	transitioned.emit("WalkArmsState")
		# elif player.hasTouchedDoor:
		# 	transitioned.emit("ChangeRoomArmsState")
