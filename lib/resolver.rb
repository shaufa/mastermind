class Resolver
  require_relative 'modules'
  include Logic
  attr_reader :guesses

  def initialize(game)
    @game = game
    @full_set = game.combination_set.dup
    @small_set = @full_set.dup

  end

  def solve
    guess = [1, 1, 2, 2]
    feedback = @game.check(guess)
    unsolved = true
    guess_num  = 1
    if feedback.sum == @game.code_length
      p 'The answer was 1 1 2 2'
      p 'Solved in the first guess!'
    else
      @full_set -= [guess]
      while unsolved
        guess = new_try(feedback, guess)
        feedback = @game.check(guess)
        p "Trying #{guess}..."
        if feedback.sum == @game.code_length
          p "The answer was #{guess}"
          p "Solved in #{guess_num} guesses!"
          unsolved = false
        end
        guess_num += 1
      end

    end
  end

  def new_try(feedback, guess)
    @small_set -= [guess]
    @small_set.each { |v| @small_set -= [v] if feedback.sort != check(v, guess).sort }
    @small_set[0]
  end
end
