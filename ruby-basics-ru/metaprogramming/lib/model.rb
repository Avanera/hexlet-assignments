# frozen_string_literal: true

# Provides a mechanism for defining attributes with type conversion.
# Allows a class to define attributes with specific types when included.
#
module Model
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  def initialize(attrs = {})
    attrs.each do |name, value|
      send("#{name}=", value)
    end
  end

  define_method('attributes') do
    instance_variables.each_with_object({}) do |var, result|
      key = var.to_s.delete('@').to_sym
      result[key] = instance_variable_get(var)
    end
  end

  private

  def convert_value(value, type)
    return value if type.nil?

    case type
    when :datetime
      DateTime.parse(value)
    when :boolean
      !!value
    when :integer
      value.to_i
    when :string
      value.to_s
    end
  end

  # Defines and converts attributes and their types at the class level.
  #
  module ClassMethods
    def attribute(name, options = {})
      attr_reader(name)

      define_method "#{name}=" do |value|
        value = convert_value(value, options[:type])
        instance_variable_set("@#{name}", value)
      end
    end
  end
end
