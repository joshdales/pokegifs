require 'json'
class PokemonController < ApplicationController

  def show
    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(res.body)
    if body == {"detail"=>"Not found."}
      id = 0
      name = "No pokemon found"
      type = "none"
    else
      id = body["id"]
      name = body["name"]
      types = body["types"].map { |type| type["type"]["name"] }
    end

    res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_API"]}&q=#{name}&rating=g")
    body = JSON.parse(res.body)
    if body == {"message"=>"Invaild authentication credentials"}
      gif_url = "Currently unavailble"
    else
      gif_url = body["data"].sample["url"]
    end

    render json: { "id": id, "name": name, "types": types, "gif": gif_url}
  end

end
