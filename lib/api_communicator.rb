require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  url = 'http://www.swapi.co/api/people/'
  the_chosen_one = nil
  character_hash = jsonify(url)

  while character_hash["next"] && !the_chosen_one do
    next_hash = character_hash["next"]
    the_chosen_one = character_hash["results"].find { |character_search| character_search["name"].downcase == character }
    character_hash = jsonify(next_hash)
  end

  if the_chosen_one == nil
    []
  else
    the_chosen_one["films"]
  end
end

def jsonify(url)
  hash = RestClient.get(url);
  JSON.parse(hash)
end


def parse_character_movies(films_hash)
  # binding.pry
  films_hash.collect do |film_url|
    jsonify(film_url)["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  # binding.pry
  if parse_character_movies(films_hash).length > 0
    puts parse_character_movies(films_hash)
  else
    puts "Bad luck"
  end
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
