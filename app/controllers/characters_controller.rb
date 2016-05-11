class CharactersController < ApplicationController
  before_action :set_character, only: [:show]

  # GET /characters
  # GET /characters.json
  def index
    time = DateTime.now.to_s
    priv_key = "fed89f21ea9aacf5b466c71c5f204ce2bceb20c6"
    pub_key = "c41cfb7b4ddfdb45d65541327e4089ba"
    hash = Digest::MD5.hexdigest(time + priv_key + pub_key);
    limit = 20
    offset = (params[:page].to_i) * limit
    response = HTTP.get("http://gateway.marvel.com/v1/public/characters", :params => {:apikey => pub_key, :ts => time, :hash => hash, :limit => limit, :offset => offset}).parse
    @characters = response["data"]["results"]
    if request.xhr?
      render :partial => "layouts/characters"
    end
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      time = DateTime.now.to_s
      priv_key = "fed89f21ea9aacf5b466c71c5f204ce2bceb20c6"
      pub_key = "c41cfb7b4ddfdb45d65541327e4089ba"
      hash = Digest::MD5.hexdigest(time + priv_key + pub_key);
      response = HTTP.get("http://gateway.marvel.com/v1/public/characters/" + params[:id].to_s, :params => {:apikey => pub_key, :ts => time, :hash => hash}).parse
      @character = response["data"]["results"][0]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_params
      params.fetch(:character, {})
    end
end
