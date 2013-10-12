require 'rubygems'
require 'tweetsearcher/options_parser'
require 'csv'
require 'stretcher'



module TweetSearcher


  class Cli
    
    def self.run(parameters)
      
      es = Stretcher::Server.new(parameters[:url])

      es.index(:tweets).delete if es.index(:tweets).exists?

      es.index(:tweets).bulk_index [].tap { |docs|

        CSV.foreach(parameters[:file], headers: true) do |row|

          docs << row.to_hash.merge({
            '_type' =>'tweet',
            '_id'   =>row['tweet_id']
          })
        end
      }
    end
  end
end