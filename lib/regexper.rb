require 'treetop'
require 'regexper/modules'

module Regexper
  base_path = File.expand_path(File.dirname(__FILE__))

  Treetop.load(File.join(base_path, 'regexper_parser.treetop'))
  @@parser = RegexperParser.new

  def self.parse(data)
    tree = @@parser.parse(data)

    if tree.nil?
      raise Exception, "Parse error: #{@@parser.failure_reason} line=#{@@parser.failure_line}, column=#{@@parser.failure_column}"
    end

    Subexp.class_variable_set(:@@capture_group, 0)
    tree.to_obj # Set capture groups

    return tree
  end
end
