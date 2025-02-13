# this script creates the BodyStateMachine class
# the BodyStateMachine will be used for handling states specific to the players body
# (idle, walk, transitionrooms, etc.)
# this class inherits from the base StateMachine class
# this means all we need in this script are the things below
class_name BodyStateMachine
extends StateMachine

# if extra functionality is needed that is specific to the body class it would look like this:

# func _process(delta):
#    super(delta)   !!!! Calls the original _process() from StateMachine and executes that logic !!!!
#    !!!! any additonal logic goes here !!!!
