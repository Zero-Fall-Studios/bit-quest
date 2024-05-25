extends Node

func parse_by_file_name(file_name: String) -> Array[Dictionary]:

  var dialogue_data: Array[Dictionary] = []

  if not FileAccess.file_exists(file_name):
    return dialogue_data

  var file = FileAccess.open(file_name, FileAccess.READ)
  var lines = file.get_as_text().split("\n")

  var current_scene = {}
  var current_entry = {}

  for line in lines:
      line = line.strip_edges()
      
      if line.begins_with("#"):
          if current_scene.has("name"):
              if current_entry.size() > 0:
                  if not current_scene.has("dialogue"):
                      current_scene["dialogue"] = []
                  current_scene["dialogue"].append(current_entry)
              dialogue_data.append(current_scene)
          current_scene = {"name": line.lstrip("#").strip_edges(), "dialogue": []}
          current_entry = {}
      
      elif line.begins_with("-"):
          if current_scene.has("name"):
              var choice_data = line.lstrip("-").strip_edges().split(" -> ")
              var choice_text = choice_data[0]
              var next_scene = choice_data[1]
              if not current_entry.has("choices"):
                  current_entry["choices"] = []
              current_entry["choices"].append({"text": choice_text, "next_scene": next_scene})
      
      elif ":" in line:
          var speaker_data = line.split(":")
          var speaker = speaker_data[0].strip_edges()
          var text = speaker_data[1].strip_edges()
          if current_scene.has("name"):
              if current_entry.size() > 0:
                  current_scene["dialogue"].append(current_entry)
              current_entry = {"speaker": speaker, "text": text, "choices": []}

  if current_entry.size() > 0:
      current_scene["dialogue"].append(current_entry)
  if current_scene.has("name"):
      dialogue_data.append(current_scene)

  file.close()
  return dialogue_data
