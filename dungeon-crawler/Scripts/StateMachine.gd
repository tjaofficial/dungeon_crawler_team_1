# this script creates the StateMachine class, which all of our different state
# machines will inherit from
class_name StateMachine
extends Node

# defines variables for tracking movement btwn states
# defines empty dictionary to be loaded with states
@export var current_state: State
var previous_state: State
@export var states: Dictionary = {}


# defines _ready function which:
# 1. checks if children of state machine are of class State
# 2. if they are valid States, they are placed into the states dictionary
# 3. connects each state to on_child_transitioned function
func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transitioned.connect(on_child_transitioned)
		else:
			push_warning("State machine contains child which is not 'State'")


# defines process function which calls update withion each state 
# updates every frame
func _process(delta):
	current_state.Update(delta)


# defines physics_process function which:
# 1. calls physics_update within each state
# 2. updates every tick (60/s)
func _physics_process(delta):
	current_state.Physics_update(delta)


# defines on_child_transitioned which: 
# 1. runs when transitioned signal is emitted from a state
# 2. reads the "new" state sent by the signal
# 3. sets current state to the "new" state
func on_child_transitioned(new_state_name: StringName) -> void:
	if current_state != null:
		previous_state = current_state
	
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != current_state:
			
			current_state.Exit()
			new_state.Enter()
			
			current_state = new_state
	else:
		push_warning("Called transition on a state that does not exist")


# defines set_initial_state function, which:
# 1. will be called from the player controller script in _ready
# 			eg. state_machine.set_initial_state("IdleState")\
# 2. sets current state to the called for state
# 3. calls Enter on current state
func set_initial_state(initial_state: StringName):
	if states.has(initial_state):
		current_state = states.get(initial_state)
	current_state.Enter()
