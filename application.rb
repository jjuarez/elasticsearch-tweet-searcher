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
      
      EM = Stretcher::Server.new(ENV['ELASTICSEARCH_URL'])
    end
    
    
    helpers do

      def current?(path="/")
        
        (request.path == path || request.path == path+'/') ? "current" : nil
      end
    end
    
    not_found do
    
      slim :not_found
    end
  
    ##
    # Routes
    get '/' do
      
      slim :home
    end
    
    
    get '/contacto' do
      
      slim :contact
    end
    
    
    get '/search' do
      
      slim :search
    end
    
    
    post '/show_tweets' do
      
      slim :tweets, locals: {
        
        tweets: Tweets.match(EM, text: params[:word], size: 100)
      }
    end
  end
end