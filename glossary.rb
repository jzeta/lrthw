glossary_file, answer_file = ARGV

prompt = '> '

f = File.open(glossary_file)
fdata = f.read()
f.rewind()

answers = File.open(answer_file, 'w')

line = 0

while line < fdata.length 
  #f.seek(line, IO::SEEK_SET)
  puts "Define #{f.readline()}"
  print prompt
  answer = STDIN.gets.chomp()
  answers.write("#{answer}\n")
  puts "Correct Definition:"
  puts "#{f.readline()}"
  puts "Retype the correct definition:"
  print prompt
  STDIN.gets.chomp()
  f.readline()
end

f.close()