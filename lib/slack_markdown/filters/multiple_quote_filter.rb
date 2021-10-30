# frozen_string_literal: true

require 'html/pipeline'
require 'slack_markdown/filters/ignorable_ancestor_tags'

module SlackMarkdown
  module Filters
    class MultipleQuoteFilter < ::HTML::Pipeline::Filter
      include IgnorableAncestorTags

      def call
        doc.search('.//text()').each do |node|
          content = node.to_html
          next if has_ancestor?(node, ignored_ancestor_tags)
          next unless content.include?('&gt;&gt;&gt;')

          html = multiple_quote_filter(content)
          next if html == content

          node.replace(html)
        end
        doc
      end

      private

      def multiple_quote_filter(text)
        lines = text.split(/^&gt;&gt;&gt;(?:\s|\n)*/, 2)
        if lines.size < 2
          text
        else
          "#{lines.join('<blockquote>')}</blockquote>"
        end
      end
    end
  end
end
