class_name Mob
extends CharacterBody2D

@onready var player: Player = get_node("/root/Game/Player")
@onready var slime: Slime = %Slime
@export var SPEED: float = 300.0
@export var HEALTH: int = 3

func _ready() -> void:
    slime.play_walk()

func _physics_process(_delta: float) -> void:
    var direction = global_position.direction_to(player.global_position)
    velocity = direction * SPEED
    move_and_slide()

func take_damage():
    HEALTH -= 1
    slime.play_hurt()

    if HEALTH <= 0:
        queue_free()
        const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
        var smoke = SMOKE_SCENE.instantiate()
        get_parent().add_child(smoke)
        smoke.global_position = global_position

