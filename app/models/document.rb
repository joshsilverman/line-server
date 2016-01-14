class Document < ActiveRecord::Base
  has_many :lines

  def preprocess
    File.foreach(filename).with_index do |text, number|
       puts "#{number}: #{text}"
       line = lines.find_or_initialize_by(number: number)
       line.text = text
       line.save!
    end
  end
end
