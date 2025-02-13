# this script creates the ArmsStateMachine class
# the ArmsStateMachine will be used for handling states specific to the players arms
# (idle, walk, attack, transitionrooms, etc.)
# this class inherits from the base StateMachine class
# this means all we need in this script are the things below
# NOTE the arms state will control animations for both the ARMS and the WEAPON
class_name ArmsStateMachine
extends StateMachine

# if extra functionality is needed that is specific to the arms class it would look like this:

# func _process(delta):
#    super(delta)   !!!! Calls the original _process() from StateMachine and executes that logic !!!!
#    !!!! any additonal logic goes here !!!!
