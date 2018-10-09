class BattlesController < ApplicationController
  before_action :find_battle, only: [:show, :edit, :update, :create_example, :completed]

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
    unless @battle.id
      render_404
    else
      redirect_to battle_path(@battle)
    end
  end

  def show
    @battle.update_attributes(turn: rand(1..2)) if @battle.turn == nil
    if @battle.left_scores > 0 and @battle.right_scores > 0
      @battle.update_attributes(example: nil, answer: nil )
    else
      add_statistics(@battle) if @battle.example != nil
      @battle.update_attributes(example: nil, answer: nil )
      redirect_to action: "completed"
    end
  end

  def new
    @battle = Battle.new
    @left_player = Player.new
    @right_player = Player.new
  end

  def edit
  create_example unless @battle.example
  end

  def update
    @battle.seconds = (DateTime.now.to_i - @battle.start_kick)
    @battle.answer = battle_params[:answer]
    change_turn(@battle)
    @battle.wound = @battle.seconds > 10 ? 0 : 20 - @battle.seconds
    @battle.save
    if @battle.answer == @battle.result
      @battle.hit = true
      activate_wound@battle
    end
    redirect_to battle_path @battle
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
    @battle.example = number1.to_s + sign1 + number2.to_s + sign2 + number3.to_s + ' = '
    @battle.result = result
    @battle.hit = false
    @battle.start_kick = DateTime.now.to_i
    @battle.save
  end

  def completed
    if @battle.left_scores > 0 and @battle.right_scores > 0
      redirect_back(fallback_location: battle_path(@battle))
    end
  end

  private

  def add_statistics(battle)
    player1 = Player.where(name: battle.left_player).first
    player2 = Player.where(name: battle.right_player).first
    player1.games += 1
    player2.games += 1
    if battle.left_scores == 0
      player2.victories += 1
      player1.losses += 1
    elsif battle.right_scores == 0
      player1.victories += 1
      player2.losses += 1
    end
    player1.save
    player2.save
  end

  def activate_wound(battle)
    if battle.turn == 1
      battle.left_scores -= @battle.wound
      battle.left_scores = battle.left_scores < 0 ? 0 : battle.left_scores
    else
      battle.right_scores -= @battle.wound
      battle.right_scores = battle.right_scores < 0 ? 0 : battle.right_scores
    end
    battle.save
  end

  def change_turn(battle)
    if battle.turn == 2
      battle.turn = 1
    else
      battle.turn = 2
    end
    battle.save
  end

  def find_battle
    @battle = Battle.where(id: params[:id]).first
    redirect_to new_battle_path  unless @battle
  end

  def battle_params
    params.require(:battle).permit(:left_player, :right_player, :answer)
  end
end
