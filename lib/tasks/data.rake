namespace :data do

  task :generate, [:filename, :lines_count, :words_per_line]  => :environment  do |t, args|
    lines_count = args.lines_count.to_i
    words_per_line = args.words_per_line.to_i
    filename = args.filename

    # clear file
    f = File.new(filename, "w")
    f.close

    open(filename, 'a') do |f|
      lines_count.times do
        f.puts "word " * words_per_line
      end
    end
  end
end
