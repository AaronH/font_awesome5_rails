require_relative 'parse_methods'

class FaIconParser
  include ParseMethods

  attr_reader :icon, :options, :data, :style, :text, :title, :sr_text, :sr_class, :appended, :attrs

  def initialize(icon, options)
    @icon     = icon
    @options  = options
    @data     = options[:data]
    @style    = options[:style]
    @text     = options[:text]
    @title    = options[:title]
    @sr_text  = options[:sr_text]
    @sr_class = options[:sr_class] || 'show-for-sr'
    @attrs    = options.except(:text, :type, :class, :icon, :animation, :size, :sr_text, :sr_class, :appended)
  end

  def appended?
    !!@options[:appended]
  end

  def classes
    @classes ||= get_all_classes
  end

  def sizes
    @sizes ||= @options[:size].nil? ? "" : arr_with_fa(@options[:size]).uniq.join(" ").strip
  end

  private

  def get_all_classes
    tmp = []
    tmp << icon_type(@options[:type])
    tmp += arr_with_fa(@icon)
    tmp += @options[:class].split(" ") unless @options[:class].nil?
    tmp += arr_with_fa(@options[:size]) unless @options[:size].nil?
    tmp += arr_with_fa(@options[:animation]) unless @options[:animation].nil?
    tmp.uniq.join(" ").strip
  end
end
