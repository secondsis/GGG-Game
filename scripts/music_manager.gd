extends Node

var audio_player : AudioStreamPlayer

func _ready() -> void:
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)

func play_sound(path: String):
	play_sound_stream(load(path))

func play_sound_stream(stream: AudioStream):
	var sound_player = AudioStreamPlayer.new()
	add_child(sound_player)
	sound_player.stream = stream
	sound_player.play()
	await sound_player.finished
	sound_player.queue_free()

func play_music(path: String, override := false):
	play_music_stream(load(path), override)

func play_music_stream(stream: AudioStream, override := false):
	if !override and audio_player.stream and audio_player.playing:
		return
	
	audio_player.stream = stream
	audio_player.play()

func stop_music():
	audio_player.stop()
