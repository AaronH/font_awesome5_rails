require "font_awesome5_rails/parsers/fa_icon_parser"
require "font_awesome5_rails/parsers/fa_layered_icon_parser"
require "font_awesome5_rails/parsers/fa_stacked_icon_parser"

module FontAwesome5
  module Rails
    module IconHelper

      def fa_icon(icon, options = {})
        parser = FaIconParser.new(icon, options)

        tags = [fa_icon_tag(parser), fa_sr_tag(parser)]
        tags << fa_text_tag(parser.text, parser, ['fa5-text', parser.sizes, ('appended' if parser.appended?)])

        (parser.appended? ? tags.reverse : tags).flatten.compact.sum
      end

      def fa_icon_tag(parser)
        content_tag(:i, nil, class: parser.classes, **parser.attrs)
      end

      def fa_text_tag(text, parser, _classes = nil )
        unless text.blank?
          content_tag(:span, text, class: [*_classes].flatten.reject(&:blank?), style: parser.style)
        end
      end

      def fa_sr_tag(parser)
        unless parser.sr_text.blank?
          text = parser.sr_text.is_a?(String) ? parser.sr_text : parser.text
          fa_text_tag text, parser, parser.sr_class
        end
      end


      def fa_stacked_icon(icon, options = {})
        parser = FaStackedIconParser.new(icon, options)

        tags = content_tag :span, class: parser.span_classes, title: parser.title do
          content_tag(:i, nil, class: (parser.reverse ? parser.second_icon_classes : parser.first_icon_classes) ) +
          content_tag(:i, nil, class: (parser.reverse ? parser.first_icon_classes : parser.second_icon_classes) )
        end
        tags += parser.text unless parser.text.nil?
        tags
      end

      def fa_layered_icon(options = {}, &block)
        parser = FaLayeredIconParser.new(options)
        if parser.size.nil?
          content_tag(:span, class: parser.classes, title: parser.title, style: parser.style, &block)
        else
          content_tag :div, class: "fa-#{parser.size}" do
            content_tag(:span, class: parser.classes, title: parser.title, style: parser.style, &block)
          end
        end
      end

    end
  end
end