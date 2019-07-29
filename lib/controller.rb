require 'gossip'

class ApplicationController < Sinatra::Base
  # Index Page
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  # Redirect to the Gossip Creation Page
  get '/gossips/new/' do
    erb :new_gossip
  end

  # Store the gossip entered by the user into the CSV file (gossip.csv)
  post '/gossips/new/' do
    Gossip.new(params['gossip_author'], params['gossip_content']).save
    redirect '/'
  end

  # Different Gossip pages by id
  get '/gossips/:id/' do |id|
    erb :gossip_page, locals: {id: id, gossip: Gossip.find(id.to_i - 1)}
  end

  # Add a Comment to the gossip
  post '/gossips/:id/' do |id|
    Gossip.add_comment(id.to_i-1, params['comment_author'], params['comment'])
    redirect "/gossips/#{id}/"
  end

  # Edit page for gossips
  get '/gossips/:id/edit/' do |id|
    erb :edit, locals: {id: id, gossip: Gossip.find(id.to_i - 1)}
  end

  # Take into account the edit to the gossip
  post '/gossips/:id/edit/' do |id|
    Gossip.update(id.to_i-1, params['gossip_author'], params['gossip_content'])
    redirect "/gossips/#{id}/"
  end
end
