window.namespace = (ns_string, root = window) ->
  ns_array = ns_string.split('.')
  progress = []
  
  previous_level = root
  
  for current_level in ns_array
    progress.push current_level
    if previous_level[current_level]?
      if previous_level[current_level].constructor != Object
        throw "Namespace error! Augmentation not allowed for non-objects. '#{progress.join('.')}' is a type of #{typeof previous_level[current_level]}. Namespace '#{ns_string}' could not be defined."
    else
      previous_level[current_level] = {}
    previous_level = previous_level[current_level]
  previous_level
