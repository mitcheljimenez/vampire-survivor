extends Node2D

@onready var path_follow = %PathFollow2D
@onready var game_over_canvas = %GameOver

func spawn_mob() -> void:
    var mob = preload("res://scenes/mob.tscn").instantiate()
    path_follow.progress_ratio = randf()
    mob.global_position = path_follow.global_position
    add_child(mob)

func _on_mob_timer_timeout() -> void:
    spawn_mob()

func _on_player_health_depleted() -> void:
    game_over_canvas.show()
    get_tree().paused = true
