require 'rubygems'
require 'csv'
require 'stretcher'


module TweetSearcher


  class Cli
    
    def self.run(parameters)
      
      es = Stretcher::Server.new('http://127.0.0.1:9200')

      es.index(:tweets).delete if es.index(:tweets).exists?

      es.index(:tweets).bulk_index [].tap do |docs|

        CSV.parse(parameters[:file], headers: true) do |row|

          docs << row.to_hash.merge({
            '_type' =>'tweet',
            '_id'   =>row['tweet_id']
          })
        end
      end
    end
  end
end