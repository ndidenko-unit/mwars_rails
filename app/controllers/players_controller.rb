class PlayersController < ApplicationController


  def index
    @players = Player.all
  end

  def create
    begin
      @player = Player.create(player_params)
      if @player.errors.empty?
        redirect_to player_path(@player)
      else
        render "new"
      end
    rescue
      @player = Player.where(player_params).first
      redirect_to player_path(@player)
    end
  end

  def show
    @player = Player.where(id: params[:id]).first
    unless @player
      render text: "Page not found", status: 404
    end
  end

  def new
    @player = Player.new #что бы при загрузке формы нью, поля были пустые
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end

end
