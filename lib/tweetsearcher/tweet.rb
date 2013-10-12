module TweetSearcher
  
  
  class Tweets
  
    def self.match(es, text: 'elasticsearch', size: 1000)
    
      es.index(:tweets).search(size: size, query: { 
        match: { text: text } }
      )
    end
  end
end