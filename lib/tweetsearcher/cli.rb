# encoding: utf-8
require 'rubygems'
require 'tweetsearcher/options_parser'
require 'csv'
require 'stretcher'



module TweetSearcher


  class Cli

    attr_reader :es
     
    def initialize(url: ENV['ELASTICSEARCH_URL'], loglevel: ::Logger::INFO)
      
      @logger       = ::Logger.new(STDOUT)
      @logger.level = loglevel
      
      @es           = Stretcher::Server.new(url)
        
      self
    end

    
    def delete_index(index)
    
      if @es.index(index).exists?
        
        @logger.warn("Deleting index: '#{index}")
        @es.index(index).delete
      end
    end
    
    
    def run(file)
   
      @logger.info("Running...")
      
      delete_index(:tweets)

      es.index(:tweets).bulk_index [].tap { |docs|

        CSV.foreach(file, headers: true, encoding: "utf-8") do |row|
          
          @logger.debug row.inspect
          docs << row.to_hash.merge({ '_type' =>'tweet', '_id' =>row['tweet_id']})
        end
      }
    end
  end
end