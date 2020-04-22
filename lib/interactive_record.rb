require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'

class InteractiveRecord

  def self.table_name
    self.to_s.downcase.pluralize # returns  "songs"
  end

  def self.column_names
    DB[:conn].results_as_hash = true

    sql = "pragma table_info('#{self.table_name}')"

    table_info = DB[:conn].execute(sql)
    column_names = []
    table_info.each {|column|
      column_names << column["name"]
    }
    column_names.compact
  end

  def initialize(options={})
    options.each { |property, value|
      self.send(("#{property}="), value)
    }
  end

  def table_name_for_insert
    self.class.table_name #"songs"
  end

  def col_names_for_insert
    self.class.column_names.delete_if { |column| column == "id"}
    binding.pry
  end











end
