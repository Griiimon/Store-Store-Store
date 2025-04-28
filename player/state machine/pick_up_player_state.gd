class_name PickUpPlayerState
extends PlayerStateMachineState

var crate: Crate



func on_enter():
	reset_hand_positions()
	hand_offset_tween= create_tween()
	right_hand_tween= create_tween()
	left_hand_tween= create_tween()
	
	hand_offset_tween.tween_property(player.hands_offset, "global_position:y", crate.global_position.y, 0.5)
	right_hand_tween.tween_property(player.right_hand, "position:x", 0.1, 0.2).as_relative()
	right_hand_tween.tween_property(player.right_hand, "position:x", -0.1, 0.3).as_relative()
	left_hand_tween.tween_property(player.left_hand, "position:x", -0.1, 0.2).as_relative()
	left_hand_tween.tween_property(player.left_hand, "position:x", 0.1, 0.3).as_relative()
	hand_offset_tween.tween_callback(reparent_crate.bind(crate))

	hand_offset_tween.tween_property(player.hands_offset, "position:y", player.orig_hand_offset_pos.y, 0.5)
	hand_offset_tween.tween_callback(on_tween_finished)


func reparent_crate(crate: Crate):
	crate.pick_up(player)
	player.carried_crate= crate

	var parent_node: Node
	match crate.size:
		Crate.Size.LARGE:
			parent_node= player.carry_large_offset
		Crate.Size.SMALL:
			parent_node= player.carry_small_offset

	crate.reparent(player.hands_offset)


func on_tween_finished():
	finished.emit()
