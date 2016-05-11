class ComicsController < ApplicationController
  before_action :set_comic, only: [:show]


  # GET /comics
  # GET /comics.json
  def index
    time = DateTime.now.to_s
    priv_key = "fed89f21ea9aacf5b466c71c5f204ce2bceb20c6"
    pub_key = "c41cfb7b4ddfdb45d65541327e4089ba"
    hash = Digest::MD5.hexdigest(time + priv_key + pub_key);
    limit = 20
    offset = (params[:page].to_i) * limit
    response = HTTP.get("http://gateway.marvel.com/v1/public/comics", :params => {:apikey => pub_key, :ts => time, :hash => hash, :limit => limit, :offset => offset}).parse
    @comics = response["data"]["results"]
    if request.xhr?
      render :partial => "layouts/comics"
    end
  end

  # GET /comics/1
  # GET /comics/1.json
  def show
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_comic
      time = DateTime.now.to_s
      priv_key = "fed89f21ea9aacf5b466c71c5f204ce2bceb20c6"
      pub_key = "c41cfb7b4ddfdb45d65541327e4089ba"
      hash = Digest::MD5.hexdigest(time + priv_key + pub_key);
      response = HTTP.get("http://gateway.marvel.com/v1/public/comics/" + params[:id].to_s, :params => {:apikey => pub_key, :ts => time, :hash => hash}).parse
      @comic = response["data"]["results"][0]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comic_params
      params.fetch(:comic, {})
    end
end
