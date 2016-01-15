class Document < ActiveRecord::Base
  has_many :lines, dependent: :destroy

  def preprocess
    lines.delete_all

    File.foreach(filename).with_index do |text, number|
      # option 1: does not scale
      # line = lines.create(number: number, text: text)
      # line = nil

      # option 2: can increase system complexity
      #           ie. we lose active model validations
      Line.connection.execute %{
          INSERT INTO lines (document_id, number, text, created_at, updated_at) 
            values (#{id}, #{number}, "#{text}", "#{text}", "#{text}, (now() at time zone 'utc'), (now() at time zone 'utc')")
        }
    end
  end
end
