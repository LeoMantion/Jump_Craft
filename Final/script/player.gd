extends CharacterBody2D

# Définition des constantes pour la vitesse et la vélocité de saut.
const SPEED = 600.0
const JUMP_VELOCITY = -500.0
const MIN_JUMP_FORCE = -400.0
const MAX_JUMP_FORCE = -610.0
const JUMP_TIME_THRESHOLD = 1 # Limite de temps d'appui pour le saut en secondes

# Récupération de la gravité par défaut depuis les paramètres du projet.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Variable pour stocker la dernière action utilisée
var last_action = ""
var movement_blocked = false

# Variable pour suivre le temps d'appui sur le bouton de saut
var jump_pressed_time = 0.0

func _process(delta):
	# Vérifie si le personnage marche et joue l'animation correspondante
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and is_on_floor() and not movement_blocked:
		if not $Walk.is_playing():
			$Walk.play()
	if not ((Input.is_action_pressed("left") or Input.is_action_pressed("right")) and is_on_floor() and not movement_blocked):
		if $Walk.is_playing():
			$Walk.stop()
	# Vérifie si la touche "fin" est pressée pour téléporter le joueur
	if Input.is_action_pressed("end"):
		# Téléporter le joueur à la position spécifiée
		position.x = 555
		position.y = -8700
	if (position.x >= 500 and position.x <= 600) and (position.y >= -8890 and position.y <= -8880):
		# Afficher l'image 'End' et cacher le sprite 2D
		$End.visible = true
		$Sprite2D.visible = false
		movement_blocked = true

func _physics_process(delta):
	# Calcul de la gravité si le personnage n'est pas au sol.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_pressed("jump") and is_on_floor():
		# Si le bouton de saut est enfoncé et que le personnage est au sol,
		# suivre le temps d'appui
		jump_pressed_time += delta
		movement_blocked = true

	if Input.is_action_just_released("jump") and is_on_floor():
		# Si le bouton de saut est relâché et que le personnage est au sol,
		# déterminez la force de saut en fonction du temps d'appui
		var jump_time = clamp(jump_pressed_time, 0, JUMP_TIME_THRESHOLD)
		var jump_force = lerp(MIN_JUMP_FORCE, MAX_JUMP_FORCE, jump_time / JUMP_TIME_THRESHOLD)
		velocity.y = jump_force

		jump_pressed_time = 0.0 # Réinitialiser le temps d'appui
		movement_blocked = false

	# Gestion du déplacement horizontal.
	var direction = 0
	if Input.is_action_pressed("left") and not movement_blocked:
		direction -= 1
		last_action = "left"
	if Input.is_action_pressed("right") and not movement_blocked:
		direction += 1
		last_action = "right"
	
	if direction != 0:
		# Si une direction est entrée, ajuste la vélocité horizontale en conséquence.
		velocity.x = direction * SPEED
		# Jouer l'animation de marche dans la direction appropriée
		if direction < 0:
			$AnimationPlayer.play("run_l")
		elif direction > 0:
			$AnimationPlayer.play("run_r")
		# Stocker la dernière action utilisée comme déplacement
		last_action = "left" if direction < 0 else "right"
	else:
		# Si aucune direction n'est entrée, décélère le personnage jusqu'à l'arrêt complet.
		velocity.x = move_toward(velocity.x, 0, SPEED)
		# Si le personnage est immobile, jouer l'animation d'inactivité dans la direction appropriée
		if velocity.x == 0:
			if last_action == "left":
				$AnimationPlayer.play("inactif_l")
			elif last_action == "right":
				$AnimationPlayer.play("inactif_r")

	# Déplacement du personnage en tenant compte de la collision avec le sol et les autres objets.
	move_and_slide() #ne pas modifier cette ligne
