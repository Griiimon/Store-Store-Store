class_name PlayerStateMachine
extends FiniteStateMachine

@onready var default_state: DefaultPlayerState = $Default
@onready var pick_up_state: PickUpPlayerState = $"Pick Up"
@onready var carrying_state: CarryingPlayerState = $Carrying
@onready var drop_state: DropPlayerState = $Drop



func _ready() -> void:
	default_state.pick_up.connect(pick_up)
	pick_up_state.finished.connect(change_state.bind(carrying_state))
	carrying_state.drop.connect(change_state.bind(drop_state))
	drop_state.finished.connect(change_state.bind(default_state))


func pick_up(crate: Crate):
	pick_up_state.crate= crate
	change_state(pick_up_state)
