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
    change_turn@battle
  end

  def new
    @battle = Battle.new
    @left_player = Player.new #что бы при загрузке формы нью, поля были пустые
    @right_player = Player.new
  end

  def edit
  end

  def update

  end

  private

  def wound(shot, scores_side)
    @battle.scores_side -= shot
    if @battle.scores_side < 0
      @battle.scores_side = 0
    end
  end

  def change_turn(battle)
    if battle.turn == 2
      battle.turn = 1
    else
      battle.turn = 2
    end
    battle.save
  end

  def create_example
    number1 = rand(0..99)
    sign1 = rand(0..1)
    number2 = rand(0..99)
    sign2 = rand(0..1)
    number3 = rand(0..99)
    if sign1 == 0
      result = number1 + number2
      sign1 = " + "
    else
      result = number1 - number2
      sign1 = " - "
    end
    if sign2 == 0
      result += number3
      sign2 = " + "
    else
      result -= number3
      sign2 = " - "
    end
    example[0] = "#{number1}#{sign1}#{number2}#{sign2}#{number3} = "
    example[1] = result.to_s
    example
  end

  def battle_params
    params.require(:battle).permit(:left_player, :right_player)
  end
end
