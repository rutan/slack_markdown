# frozen_string_literal: true

require 'html/pipeline'
require 'slack_markdown/filters/ignorable_ancestor_tags'

module SlackMarkdown
  module Filters
    class StrikeFilter < ::HTML::Pipeline::Filter
      include IgnorableAncestorTags

      def call
        doc.search('.//text()').each do |node|
          content = node.to_html
          next if has_ancestor?(node, ignored_ancestor_tags)
          next unless content.include?('~')

          html = strike_filter(content)
          next if html == content

          node.replace(html)
        end
        doc
      end

      def strike_filter(text)
        text.gsub(STRIKE_PATTERN) do
          "<strike>#{Regexp.last_match(1)}</strike>"
        end
      end

      STRIKE_PATTERN = /(?<=^|\W)~(.+)~(?=\W|$)/.freeze
    end
  end
end
