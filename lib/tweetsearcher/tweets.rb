module TweetSearcher
  
  
  class Tweets
    
    DEFAULT_TEXT = "ruby"
    DEFAULT_SIZE = 1000
    
    def self.match(es, text: DEFAULT_TEXT, size: DEFAULT_SIZE)

      es.index(:tweets).search size: size, query: { 
        match: { text: text }
      }
    end
  end
end