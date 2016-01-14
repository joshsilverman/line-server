namespace :preprocessor do

  task :preprocess, [:filename]  => :environment  do |t, args|
    puts "Processing #{args.filename}"
    document = Document.find_or_create_by(filename: args.filename)
    document.preprocess
  end
end
