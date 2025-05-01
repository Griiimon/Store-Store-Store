class_name PlayerStateMachine
extends FiniteStateMachine

@onready var default_state: DefaultPlayerState = $Default
@onready var pick_up_state: PickUpPlayerState = $"Pick Up"
@onready var carrying_state: CarryingPlayerState = $Carrying
@onready var drop_state: DropPlayerState = $Drop
@onready var hands_up_state: ChangeHandHeightPlayerState = $"Hands Up"
@onready var hands_down_state: ChangeHandHeightPlayerState = $"Hands Down"

var player: Player



func _ready() -> void:
	player= get_parent()
	
	default_state.pick_up.connect(pick_up)
	pick_up_state.finished.connect(change_state.bind(carrying_state))
	carrying_state.drop.connect(change_state.bind(drop_state))
	drop_state.finished.connect(change_state.bind(default_state))
	hands_up_state.finished.connect(change_to_default_or_carrying)
	hands_down_state.finished.connect(change_to_default_or_carrying)


func pick_up(crate: Crate):
	pick_up_state.crate= crate
	change_state(pick_up_state)


func hands_up():
	if hands_up_state.is_current_state(): return
	change_state(hands_up_state)


func hands_down():
	if hands_down_state.is_current_state(): return
	change_state(hands_down_state)


func change_to_default_or_carrying():
	if player.carried_crate:
		change_state(carrying_state)
	else:
		change_state(default_state)
