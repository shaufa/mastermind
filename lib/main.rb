require_relative 'game'
require_relative 'resolver'
require_relative 'modules'
include Print

puts 'Welcome to Mastermind'
puts 'Would you like to be the guesser? (answer with Y for YES or anything elsee for no)'
if %w[Y y].include?(gets.chomp)

  # Code for playing human VS machine
  game = Game.new
  p game.code_length
  p game.options_number
  unsolved = true
  guesses = []

  puts 'All set! Make your first guess!'
  while unsolved
    guess = gets.chomp.split.map(&:to_i)
    feedback = game.check(guess)
    unsolved = false if feedback.length == game.code_length && feedback.all?(1)
    guesses.push([guess, feedback])
    puts "Wrong answer, here's the feedback:"
    print_feedback(guesses)
    puts 'Try again :)'
  end

  puts "Congratulations! You won in #{guesses.length} guesses!"

else

  # Code for playing machine VS human
  game = Game.new(true)
  resolver = Resolver.new(game)

  resolver.solve

end
