extends CharacterBody2D

# initialize references to state machines on ready
@onready var bodyStateMachine := $BodyStateMachine
@onready var armsStateMachine := $ArmsStateMachine

# initialize references to player sprite layers
@onready var weaponSprite := $Skeleton/PlayerWeapon
@onready var armsSprite := $Skeleton/PlayerArms
@onready var bodySprite := $Skeleton/PlayerLegs

var cardinalDirection : String # NSEW directions
var lastDirection := Vector2.ZERO # vector2 for last player facing dir
var inputDirectionVector  := Vector2.ZERO # vector2 for current player input dir

var isTouchingDoor := false # INCOMPLETE: check if player is touching door for room trans

#player movement speed
var moveSpeed := 50.0

func _ready() -> void:
	# set initial idle states for both state machines
	bodyStateMachine.set_initial_state("IdleBodyState")
	armsStateMachine.set_initial_state("IdleArmsState")
	
	# set initial player direction as North
	cardinalDirection = "N"
	
	# assign signals to animation update functions
	for state in bodyStateMachine.get_children():
		if state is State:
			state.body_animation_changed.connect(update_body_animations)
	for state in armsStateMachine.get_children():
		if state is State:
			state.arms_animation_changed.connect(update_arms_animations)
	

func _process(_delta: float) -> void:
	pass
	# pushes player velocity in walk state to movement
func _physics_process(delta: float) -> void:
		# Get player direction Vector2
	inputDirectionVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	inputDirectionVector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	# update cardinalDirection from player dir Vector2
	if inputDirectionVector != lastDirection:
		cardinalDirection = get_cardinal_dir_from_vector2(inputDirectionVector)
		lastDirection = inputDirectionVector

# matches inputDirectionVector to a cardinal direction
func get_cardinal_dir_from_vector2(direction: Vector2) -> String:
	match direction:
		Vector2(0, -1): return "N"
		Vector2(1, -1): return "NE"
		Vector2(1, 0): return "E"
		Vector2(1, 1): return "SE"
		Vector2(0, 1): return "S"
		Vector2(-1, 1): return "SW"
		Vector2(-1, 0): return "W"
		Vector2(-1, -1): return "NW"
		_: return cardinalDirection


# passes in state name and adds cardinal direction
# plays this animation on associated sprite
func update_body_animations(bodyState: String):
	bodySprite.play("Knight-Body-"+ bodyState + "-" + cardinalDirection)

# passes in state name and adds cardinal direction
# plays this animation on associated sprite
# tracks frames for attack animations and assigns with direction change
func update_arms_animations(armsState: String):
	var current_frame = armsSprite.frame
	var was_playing = armsSprite.is_playing()
	
	armsSprite.play("Knight-Arms-"+ armsState + "-" + cardinalDirection)
	weaponSprite.play("Knight-Weapon-"+ armsState + "-" + cardinalDirection)
	# set frames below
	if armsState == "Attack" && armsSprite.is_playing():
		armsSprite.frame = current_frame
		weaponSprite.frame = current_frame
