namespace :preprocessor do

  task :preprocess, [:filename]  => :environment  do |t, args|
    filename = args.filename
    puts "Processing #{filename}"

    File.foreach(filename).with_index do |line, line_num|
       puts "#{line_num}: #{line}"
    end;
  end
end
