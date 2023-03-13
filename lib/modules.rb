module Print
  def print_feedback(feedback)
    puts 'GUESS #       GUESS         FEEDBACK'
    feedback.each_index { |v| puts "#{v+1}          #{feedback[v][0]}   #{feedback[v][1]}" }
  end
end

module Logic
  def check(guess, code)
    feedback = []
    code_copy = code.dup
    guess.each_index do |i|
      if guess[i] == code_copy[i]
        feedback.push(1)
        code_copy[i] = nil
      elsif code_copy.index(guess[i])
        unless guess[code_copy.index(guess[i])] == code_copy[code_copy.index(guess[i])]
          feedback.push(0)
          code_copy[code_copy.index(guess[i])] = nil
        end
      end
    end
    feedback
  end

end
