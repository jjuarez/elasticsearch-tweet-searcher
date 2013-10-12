require 'choice'

Choice.options do
  
  header ''
  header 'Specific options:'


  option :file, :required =>true do
    
    short '-f'
    long  '--file=your/tweets/file/archive.csv'
    desc  'The file wich contains your tweets archive in CSV format'
  end


  option :url, :required =>true do
    
    short '-u'
    long  '--url=http://127.0.0.1:9200/'
    desc  'The file wich contains your tweets archive in CSV format'
  end
    

  separator ''
  separator 'Common options: '

  option :help do

    long '--help'
    desc 'Show this message'
  end
end