class_name AttackArmsState
extends State

# get player body node and set it to variable player
# root node has been assigned in the editor
@export var player: CharacterBody2D
var lastPlayerDirection := ""
var isAttackFinishedConnected := false

func Enter():
	# calls which animation that needs to be played
	# this signal is connected in the player controller script
	# the player controller reads this signal and a match statement plays the associated animation
	arms_animation_changed.emit("Attack")
	
	lastPlayerDirection = player.cardinalDirection
	if !isAttackFinishedConnected:
		player.armsSprite.animation_finished.connect(on_attack_finished)



func Physics_update(_delta):
	# checks if direction has changed, updates animation if it has
	if player.cardinalDirection != lastPlayerDirection:
		arms_animation_changed.emit("Attack")
		lastPlayerDirection = player.cardinalDirection
	
	if player.isTouchingDoor:
		pass # room change emit here
func on_attack_finished():
	if player.inputDirectionVector.length() > 0:
		transitioned.emit("WalkArmsState")
	elif player.inputDirectionVector.length() == 0:
		transitioned.emit("IdleArmsState")
