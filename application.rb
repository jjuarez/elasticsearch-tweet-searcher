$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'sinatra/base'
require 'slim'
require 'stretcher'
require 'tweetsearcher/tweets'


module TweetSearcher
  
  
  class Application < Sinatra::Base
  
    ##
    # Configuration
    configure do
      
      set :root,          File.dirname(__FILE__)
      set :public_folder, File.join(settings.root, 'public')
      
      enable :logging
            
      EM = Stretcher::Server.new(ENV['ELASTICSEARCH_URL'])
    end
    
    ##
    # Helpers
    helpers do

      #...
    end
    
    ##
    # Error handlers
    not_found do
      slim :not_found
    end
    
    error do
      slim :error
    end
  
    ##
    # Routes
    get '/' do
      slim :home
    end
    
    get '/about' do
      slim :about
    end
    
    get '/contact' do  
      slim :contact
    end
    
    get '/search' do
      slim :search_form
    end
    
    post '/do_search' do
      
      word = params[:word]
      size = params[:size]
      
      redirect "/search" unless word
      
      slim :show_tweets, locals: {
          
        word:   word,
        size:   size,
        tweets: Tweets.match(EM, text: word, size: size)
      }
    end
  end
end