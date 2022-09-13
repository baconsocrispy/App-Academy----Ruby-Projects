require 'byebug'
class Board
  CUP_START = [:stone, :stone, :stone, :stone]
  CUP_INDICES = [*0..5,*7..12]

  attr_accessor :cups

  def initialize(name1, name2)
    @player1 = name1
    @player2 = name2
    self.cups = Array.new(14) { Array.new() }
    self.place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    CUP_INDICES.each { |cup_index| @cups[cup_index].concat(CUP_START)}
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if !CUP_INDICES.include?(start_pos)
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    # debugger
    start_cup = @cups[start_pos]
    @cups[start_pos] = []
    skip_index = current_player_name == @player1 ? 13 : 6
    next_cup_pos = start_pos

    until start_cup.empty?
      next_cup_pos + 1 == skip_index ? next_cup_pos += 2 : next_cup_pos += 1
      @cups[next_cup_pos % 14] << start_cup.shift
    end
    self.render
    next_turn(next_cup_pos)
  end

  def next_turn(ending_cup_idx) 
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 || ending_cup_idx == 13
      return :prompt
    elsif @cups[ending_cup_idx].count == 1
      return :switch
    end
    ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    side1 = [*0..5]
    side2 = [*7..12]

    side1.all? { |cup_index| @cups[cup_index].empty? } || side2.all? { |cup_index| @cups[cup_index].empty? }
  end

  def winner
    if @cups[6].count == @cups[13].count
      :draw
    elsif @cups[6].count > @cups[13].count
      @player1
    else
      @player2
    end
  end
end
