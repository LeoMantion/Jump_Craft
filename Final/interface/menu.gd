extends Control

#Fonction pour gérer la pause du jeu
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle()

#Fonction pour basculer la visibilité et la pause du jeu
func toggle():
	visible=!visible
	get_tree().paused=visible

#Gestion des événements lorsque le bouton de démarrage est pressé
func _on_button_start_pressed():
	toggle()
	get_tree().change_scene_to_file("res://scenes/world.tscn")

#Gestion des événements lorsque le bouton d'options est pressé
func _on_button_option_pressed():
	show_and_hide($TextureRect/Option, $TextureRect/Menu)

#Fonction pour afficher et masquer deux éléments de l'interface utilisateur
func show_and_hide(first, second):
	first.show()
	second.hide()

#Gestion des événements lorsque le bouton de quitter est pressé
func _on_button_quit_pressed():
	get_tree().quit()

#Gestion des événements lorsque le bouton vidéo est pressé
func _on_video_pressed():
	show_and_hide($TextureRect/Video, $TextureRect/Option)

#Gestion des événements lorsque le bouton audio est pressé
func _on_audio_pressed():
	show_and_hide($TextureRect/Audio, $TextureRect/Option)

#Gestion des événements lorsque le bouton de contrôle est pressé
func _on_contrôle_pressed():
	show_and_hide($TextureRect/Contrôle, $TextureRect/Option)

#Gestion des événements lorsque le bouton de retour depuis les options est pressé
func _on_back_from_options_pressed():
	show_and_hide($TextureRect/Menu, $TextureRect/Option)

#Gestion des événements lorsque le mode plein écran est basculé
func _on_plein_écran_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

#Gestion des événements lorsque le mode fenêtré est basculé
func _on_fenêtré_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

#Gestion des événements lorsque la synchronisation verticale est basculée
func _on_v_sync_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.VSYNC_ENABLED
	else:
		DisplayServer.VSYNC_DISABLED

#Gestion des événements lorsque le bouton de retour depuis la vidéo est pressé
func _on_back_from_video_pressed():
	show_and_hide($TextureRect/Option, $TextureRect/Video)

#Fonction pour ajuster le volume des différents canaux audio
func volume(bus_index, value):
	var volume_percentage = 0.0
	if value == 0.25:
		volume_percentage = -28
	elif value == 0.50:
		volume_percentage = -17
	elif value == 0.75:
		volume_percentage = -10
	elif value == 1:
		volume_percentage = 0
	else:
		volume_percentage = -100
	AudioServer.set_bus_volume_db(bus_index, volume_percentage)

#Gestion des événements lorsque la valeur du volume principal change
func _on_volume_principal_value_changed(value):
	volume(0,value)

#Gestion des événements lorsque la valeur de la musique change
func _on_musique_value_changed(value):
	volume(1,value)

#Gestion des événements lorsque la valeur des effets sonores change
func _on_sound_fx_value_changed(value):
	volume(2,value)

#Gestion des événements lorsque le bouton de retour depuis l'audio est pressé
func _on_back_from_audio_pressed():
	show_and_hide($TextureRect/Option, $TextureRect/Audio)

#Nous n'avons pas réussi à faire un menu de sélection des touches

#Devait permettre d'assigner la touche "Droite" en cliquant dessus
func _on_droite_pressed():
	pass

#Devait permettre d'assigner la touche "Gauche" en cliquant dessus
func _on_gauche_pressed():
	pass

#Devait permettre d'assigner la touche "Jump" en cliquant dessus
func _on_saut_pressed():
	pass

#Devait permettre d'assigner la touche "Pause" en cliquant dessus
func _on_pause_pressed():
	pass

#Gestion des événements lorsque le bouton de retour depuis les contrôles est pressé
func _on_back_from_contrôle_pressed():
	show_and_hide($TextureRect/Option, $TextureRect/Contrôle)
