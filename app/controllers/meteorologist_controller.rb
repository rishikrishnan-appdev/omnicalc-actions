require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather
    @street_address = params.fetch("user_street_address")
    sanitized_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A sanitized version of the street address, with spaces and other illegal
    #   characters removed, is in the string sanitized_street_address.
    # ==========================================================================
    
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + sanitized_street_address + "&key=AIzaSyBr-0XDfztIIUGyPRfa1D5KfPvURvAk2e4"
    parsed_data = JSON.parse(open(url).read)
    lat = parsed_data.dig("results", 0, "geometry", "location", "lat").to_s
    lng = parsed_data.dig("results", 0, "geometry", "location", "lng").to_s
    
    url = "https://api.darksky.net/forecast/abb256d5f30837cdfc6ad3d8d9952a16/" + lat + "," + lng
    parsed_data = JSON.parse(open(url).read)
    
    @current_temperature = parsed_data.dig("currently", "temperature").to_s

    @current_summary = parsed_data.dig("currently", "summary").to_s

    @summary_of_next_sixty_minutes = parsed_data.dig("minutely", "summary").to_s

    @summary_of_next_several_hours = parsed_data.dig("hourly", "summary").to_s

    @summary_of_next_several_days = parsed_data.dig("daily", "summary").to_s

    render("meteorologist_templates/street_to_weather.html.erb")
  end

  def street_to_weather_form
    render("meteorologist_templates/street_to_weather_form.html.erb")
  end
end
