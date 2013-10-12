$:.unshif File.join(File.dirname(__FILE__), 'lib')

require 'rubygems'
require 'sinatra'
require 'stretcher'
require 'tweetsearcher/tweet'


module TweetSearcher
  
  class Application < Sintrata::Base
  
    ##
    # Configuration
    configure do
      
      :root,          File.dirname(__FILE__)
      :public_folder, File.join(settings.root, 'public')
      
      EM = Stretcher::Server.new('http://127.0.0.1:9200')
    end
    
    
    ##
    # Routes
    get '/' do
      
      redirect "/elasticsearch"
    end
    
    get '/:word' do
      
      tweets: TweetSearcher::Tweets.match(EM, text: params[:word])
    end
  end
end