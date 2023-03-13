class Game
  attr_reader :combination_set, :allow_duplicates, :code_length, :options_number

  def initialize(machine_vs_human = false)
    puts 'Do you want to allow duplicates? (default: yes)'
    @allow_duplicates = ['Y', 'y', ""].include?(gets.chomp) ? true : false
    puts 'How long should the code be? (default: 4)'
    @code_length = gets.chomp.to_i
    @code_length = 4 if @code_length == 0
    puts 'How how many options do you want? (default: 6)'
    @options_number = gets.chomp.to_i
    @options_number = 6 if @options_number == 0
    @combination_set = create_set(@allow_duplicates, @code_length, @options_number)
    if machine_vs_human
      puts "What's the code?"
      @code = gets.chomp.split.map(&:to_i)
    else
      @code = @combination_set.sample
    end
  end

  def create_set(allow_duplicates, code_length, options_number)
    set = []
    if allow_duplicates
      Array((1..options_number)).repeated_permutation(code_length) { |permutation| set.push(permutation) }
    else
      Array((1..options_number)).permutation(code_length) { |permutation| set.push(permutation) }
    end
    set
  end

  def check(guess)
    @feedback = []
    @code_copy = @code.dup

    guess.each_index do |i|
      if guess[i] == @code_copy[i]
        @feedback.push(1)
        @code_copy[i] = nil
      elsif @code_copy.index(guess[i])
        unless guess[@code_copy.index(guess[i])] == @code_copy[@code_copy.index(guess[i])]
          @feedback.push(0)
          @code_copy[@code_copy.index(guess[i])] = nil
        end
      end
    end
    @feedback
  end
end
