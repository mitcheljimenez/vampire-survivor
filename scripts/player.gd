class_name Player
extends CharacterBody2D

signal health_depleted

@export var SPEED: float = 600
@export var HEALTH: float = 100.0
@export var DAMAGE_RATE: float = 5.0
@onready var happy_boo = %HappyBoo
@onready var hitbox: Area2D = %Hitbox
@onready var health_bar: Range = %HealthBar

func _ready() -> void:
    health_bar.value = HEALTH
    health_bar.max_value = HEALTH

func _physics_process(_delta: float) -> void:
    var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

    velocity = direction * SPEED
    move_and_slide()

    if velocity.length() > 0.0:
        happy_boo.play_walk_animation()
    else:
        happy_boo.play_idle_animation()

    var overlapping_mobs = hitbox.get_overlapping_bodies()
    if overlapping_mobs.size() > 0:
        HEALTH -= DAMAGE_RATE * overlapping_mobs.size() * _delta
        health_bar.value = HEALTH
        if HEALTH <= 0.0:
            health_depleted.emit()