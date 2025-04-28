class_name PlayerStateMachine
extends FiniteStateMachine

@onready var default_state: DefaultPlayerState = $Default
@onready var pick_up_state: PickUpPlayerState = $"Pick Up"
@onready var carrying_state: CarryingPlayerState = $Carrying



func _ready() -> void:
	default_state.pick_up.connect(pick_up)
	pick_up_state.finished.connect(change_state.bind(carrying_state))


func pick_up(crate: Crate):
	pick_up_state.crate= crate
	change_state(pick_up_state)
