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