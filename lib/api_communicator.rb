require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  the_chosen_one = character_hash["results"].find { |character_search| character_search["name"].downcase == character }
  the_chosen_one["films"]
end

def parse_character_movies(films_hash)
  films_hash.collect do |film_url|

    film_stuff = RestClient.get(film_url)
    film_json = JSON.parse(film_stuff)

    puts film_json["title"]
    film_json["title"]
  end

  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
