require 'sinatra'
require 'haml'

# We set up an array of viable moves that a player (and the computer) can perform.
before do
  @defeat = {
             rock: :scissors,
             paper: :rock,
             scissors: :paper
            }
  @throws = @defeat.keys
end

get '/' do
  haml :index
end

get '/throw/:type' do
  # The params[] hash stores querystring and form data.
  @player_throw = params[:type].to_sym

  # Now we can select a random throw for the computer.
  @computer_throw = @throws.sample
  
  if @throws.include?(@player_throw)
    # Compare the player and computer throws to determine a winner.
    if @player_throw == @computer_throw
      @message = "You tied with the computer!"
    elsif @computer_throw == @defeat[@player_throw]
      @message = "<span class='win'>You win!</span> #{@player_throw.capitalize} beats #{@computer_throw}!"
    else
      @message = "<span class='ouch'>Ouch!</span> #{@computer_throw.capitalize} beats #{@player_throw}."
    end
  else
    @message = "You must throw rock, paper or scissors."
  end

  haml :throw
end