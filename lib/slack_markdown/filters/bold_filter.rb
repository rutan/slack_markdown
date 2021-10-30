# frozen_string_literal: true

require 'html/pipeline'
require 'slack_markdown/filters/ignorable_ancestor_tags'

module SlackMarkdown
  module Filters
    class BoldFilter < ::HTML::Pipeline::Filter
      include IgnorableAncestorTags

      def call
        doc.search('.//text()').each do |node|
          content = node.to_html
          next if has_ancestor?(node, ignored_ancestor_tags)
          next unless content.include?('*')

          html = bold_filter(content)
          next if html == content

          node.replace(html)
        end
        doc
      end

      def bold_filter(text)
        text.gsub(BOLD_PATTERN) do
          "<b>#{Regexp.last_match(1)}</b>"
        end
      end

      BOLD_PATTERN = /(?<=^|\W)\*(.+)\*(?=\W|$)/.freeze
    end
  end
end
