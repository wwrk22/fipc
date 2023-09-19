# frozen_string_literal: true

require "json"

module JsonProcessor
  def process(dir)
    opened_dir = Dir.new dir

    opened_dir.each_child.inject([]) do |results, filename|
      file_content = File.open("#{opened_dir.path}/#{filename}", &:read)
      json = JSON.parse(file_content)
      results << (block_given? ? yield(json) : nil)
    end
  end
end
