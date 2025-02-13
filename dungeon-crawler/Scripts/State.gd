# This script creates the state class which all player states will inherit from

class_name State
extends Node

# defines a signal which inherited state scripts use to emit what the state is 
# transitioning to. This gets connected in the parent state machine of this child
signal transitioned(new_state_name: StringName)
signal body_animation_changed(new_animation: StringName)
signal arms_animation_changed(new_animation: StringName)

# state function for when a state is newly entered
func Enter() -> void:
	pass

# state function for when a state is newly exited
func Exit() -> void:
	pass

# state function for general updating, runs every frame
func Update(delta: float) -> void:
	pass

# state function for physics updating, runs every tick
func Physics_update(delta: float) -> void:
	pass
