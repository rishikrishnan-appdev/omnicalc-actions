class StatsController < ApplicationController
  def stats
    @numbers = params.fetch("list_of_numbers").gsub(",", "").split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count
    
    @minimum = @sorted_numbers.at(0)

    @maximum = @sorted_numbers.at(-1)

    @range = @maximum - @minimum

    # Median
    # ======
    if @count.odd?
      count = @count.to_f
      index = count / 2
      index = index.round 
      median = @sorted_numbers.at(index)
    else
      index = @count / 2
      median = (@sorted_numbers.at(index) + @sorted_numbers.at(index - 2))/2
    end
    
    @median = median
    
    sum = 0
    @numbers.each do |num|
      sum += num
    end
    
    @sum = sum

    @mean = @sum / @count

    # Variance
    # ========

    sum_var = 0
    @numbers.each do |num|
      sum_var += ((num - @mean) ** 2)
    end
    
    @variance = sum_var / @count

    @standard_deviation = @variance ** 0.5

    # Mode
    # ====
    
    freq = Hash.new
    freq.default = 0
    @sorted_numbers.each do |num|
      freq.store(num, freq[num] + 1)
    end
    
    mode = nil
    mode_freq = freq.fetch(@sorted_numbers.at(0))
    @sorted_numbers.each do |num|
      if freq[num] >= mode_freq
        mode = num
      end
    end
    
    @mode = mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("stats_templates/stats.html.erb")
  end

  def stats_form
    render("stats_templates/stats_form.html.erb")
  end
  
end
