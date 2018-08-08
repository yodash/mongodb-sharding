require 'rubygems'
require 'mongo'
require 'faker'

#<start id="write_docs">
@con  = Mongo::Client.new(['127.0.0.1:40000'], options = {database: "cloud-docs"})
@col  = @con[:spreadsheets]
@data = "abcde" * 1000

def write_user_docs(iterations=0, name_count=200)
  iterations.times do |n|
    name_count.times do |n|
      doc = { :filename => "sheet-#{n}",
              :updated_at => Time.now.utc,
              :username => Faker::Name.first_name,
              :data => @data
            }
      @col.insert_one(doc)
    end
  end
end
#<start id="write_docs">

if ARGV.empty? || !(ARGV[0] =~ /^\d+$/)
  puts "Usage: load.rb [iterations] [name_count]"
else
  iterations = ARGV[0].to_i

  if ARGV[1] && ARGV[1] =~ /^\d+$/
    name_count = ARGV[1].to_i
  else
    name_count = 200
  end

  write_user_docs(iterations, name_count)
end
