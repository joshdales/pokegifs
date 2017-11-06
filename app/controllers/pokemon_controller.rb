require 'json'
class PokemonController < ApplicationController

  def show
    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(res.body)
    id = body["id"]
    name = body["name"]
    types = body["types"].map { |type| type["type"]["name"] }

    res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_API"]}&q=pikachu&rating=g")
    body = JSON.parse(res.body)

    render json: { "id": id, "name": name, "types": types}
  end

end
