# frozen_string_literal: true

require 'html/pipeline'
require 'slack_markdown/filters/ignorable_ancestor_tags'

module SlackMarkdown
  module Filters
    class LineBreakFilter < ::HTML::Pipeline::Filter
      include IgnorableAncestorTags

      def call
        doc.search('.//text()').each do |node|
          content = node.to_html
          next if has_ancestor?(node, ignored_ancestor_tags)
          next unless content.include?("\n")

          html = content.gsub("\n", '<br>')
          next if html == content

          node.replace(html)
        end
        doc
      end
    end
  end
end
