class BattlesController < ApplicationController
  def index
    @battles = Battle.all
  end

  def create
    @battle = Battle.create(battle_params)
    @left_player = Player.where(name: battle_params[:left_player]).first
    unless @left_player
      @left_player = Player.create(name: battle_params[:left_player])
    end
    @right_player = Player.where(name: battle_params[:right_player]).first
    unless @right_player
      @right_player = Player.create(name: battle_params[:right_player])
    end
    @battle.players << @left_player
    @battle.players << @right_player
    redirect_to battle_path(@battle)
  end

  def show
    @battle = Battle.where(id: params[:id]).first
    unless @battle
      render text: "Page not found", status: 404
    end
  end

  def new
    @battle = Battle.new
    @left_player = Player.new #что бы при загрузке формы нью, поля были пустые
    @right_player = Player.new
  end


  private

  def battle_params
    params.require(:battle).permit(:left_player, :right_player)
  end
end
