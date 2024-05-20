# frozen_string_literal: true

# Provides a mechanism for defining attributes with type conversion.
# Allows a class to define attributes with specific types when included.
#
module Model
  # 1. `self.included` is called when the module is included using `include Model`.
  # 2. `klass.extend(ClassMethods)` extends the class `User` with methods from
  #    `ClassMethods`. These methods (`attribute` and `attributes_with_defaults`)
  #    are defined but not yet executed. They can be called using
  #    `User.attribute` and `User.attributes_with_defaults`.
  # 3. `klass.class_eval` executes the given block in the context of the
  #    class `klass`. The class `User` is assigned the instance variable
  #    `@attributes_with_defaults` (which can be accessed via
  #    `User.attributes_with_defaults`).
  def self.included(klass)
    klass.extend(ClassMethods)

    klass.class_eval do
      @attributes_with_defaults = {}
    end
  end

  # 5. `User.new(name: 'Dima', birthday: '01-2-1890')` is called.
  #    Class method `attributes_with_defaults` is called in the context
  #    of the `User` instance (`User.new`):
  #    `self.class.attributes_with_defaults =>
  #    { :name=>"Andrey", :birthday=>nil, :active=>false }`
  #    `merge(attrs)` merges passed attributes with the defaults:
  #    `=> { :name=>"Dima", :birthday=>"01-2-1890", :active=>false }`
  #    Each attribute is set with `send("#{name}=", value)`.
  def initialize(attrs = {})
    self.class.attributes_with_defaults.merge(attrs).each do |name, value|
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
    return if value.nil?
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
    # 4. In the class `User`, `attribute` is called.
    #    Example: attribute :name, type: :string, default: 'Andrey'`
    #    - A getter for `:name` is set.
    #    - The default value is added to the hash `@attributes_with_defaults`.
    #    - A setter for `:name` is dynamically defined.
    #    - In the setter, the attribute is converted to the required type.
    def attribute(name, options = {})
      attr_reader(name)

      attributes_with_defaults[name] = options[:default]

      define_method "#{name}=" do |value|
        value = convert_value(value, options[:type])
        instance_variable_set("@#{name}", value)
      end
    end

    def attributes_with_defaults
      @attributes_with_defaults
    end
  end
end
