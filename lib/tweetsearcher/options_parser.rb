require 'choice'

Choice.options do
  
  header ''
  header 'Specific options:'

  option :file do
    
    short '-f'
    long  '--file=your/tweets/file/archive.csv'
    desc  'The file wich contains your tweets archive in CSV format'
  end

  separator ''
  separator 'Common options: '

  option :help do

    long '--help'
    desc 'Show this message'
  end
end