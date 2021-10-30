# frozen_string_literal: true

require 'html/pipeline'
require 'slack_markdown/filters/ignorable_ancestor_tags'

module SlackMarkdown
  module Filters
    class MultipleCodeFilter < ::HTML::Pipeline::Filter
      include IgnorableAncestorTags

      def call
        doc.search('.//text()').each do |node|
          content = node.to_html
          next if has_ancestor?(node, ignored_ancestor_tags)
          next unless content.include?('`')

          html = multiple_code_filter(content)
          next if html == content

          node.replace(html)
        end
        doc
      end

      private

      def multiple_code_filter(text)
        text.gsub(CODE_PATTERN) do
          "<pre><code>#{Regexp.last_match(1)}</code></pre>"
        end
      end

      CODE_PATTERN = /(?<=^|\W)```\n?((?:.|\n)+?)```(?=\W|$)/.freeze
    end
  end
end
