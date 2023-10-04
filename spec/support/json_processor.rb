# frozen_string_literal: true

require "json"

# Read JSON content of each file for the given directory, then pass the data
# onto given block. Collect each block return value in an array, then return
# the array.
module JsonProcessor
  def process(dir)
    opened_dir = Dir.new dir

    opened_dir.each_child.inject([]) do |results, file_name|
      file_content = File.open("#{opened_dir.path}/#{file_name}", &:read)
      json = JSON.parse(file_content)
      results << (block_given? ? yield(json) : nil)
    end
  end
end
