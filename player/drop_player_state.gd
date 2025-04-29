class_name DropPlayerState
extends PlayerStateMachineState



func on_enter():
	assert(player.carried_crate != null)
	reset_tweens()

	right_hand_tween.tween_property(player.right_hand, "position:x", 0.15, 0.1).as_relative()
	right_hand_tween.tween_callback(drop_crate)
	right_hand_tween.tween_property(player.right_hand, "position:x", -0.15, 0.3).as_relative()
	right_hand_tween.tween_callback(finish_dropping)
	
	left_hand_tween.tween_property(player.left_hand, "position:x", -0.15, 0.1).as_relative()
	left_hand_tween.tween_property(player.left_hand, "position:x", 0.15, 0.3).as_relative()


func drop_crate():
	player.carried_crate.drop()
	player.carried_crate= null


func finish_dropping():
	finished.emit()
