class TimeBetweenController < ApplicationController
  def time_between
    @starting = Chronic.parse(params.fetch("starting_time"))
    @ending = Chronic.parse(params.fetch("ending_time"))
    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================
    
    time = @ending - @starting
    years = time / (60*60*24*365)
    weeks = (time % (years * 60*60*24*365)) / (60*60*24*7)
    days = (time % (years * 60*60*24*365 + weeks * 60*60*24*7)) / (60*60*24)
    hours = (time % (years * 60*60*24*365 + weeks * 60*60*24*7 + days * 60*60*24)) / 3600
    minutes = (time % (years * 60*60*24*365 + weeks * 60*60*24*7 + days * 60*60*24 + hours * 3600)) / 60
    seconds = time % (years * 60*60*24*365 + weeks * 60*60*24*7 + days * 60*60*24 + hours * 3600 + minutes * 60)
    
    @seconds = seconds
    @minutes = minutes
    @hours = hours
    @days = days
    @weeks = weeks
    @years = years
    # ================================================================================
    # Your code goes above.
    # ================================================================================
    

    render("time_between_templates/time_between.html.erb")
  end

  def time_between_form
    render("time_between_templates/time_between_form.html.erb")
  end
end
