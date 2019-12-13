# frozen_string_literal: true

class EsFileIndexJob < ApplicationJob
  queue_as :default

  def perform(sop_id)
    @sop = Sop.find(sop_id)
    index = Sop.search_index.name

    Searchkick.client.update index: index, id: sop_id, \
                              body: { doc: { content: content } }
  end

  private
    def content
      return "" unless  File.exist?(@sop.file.path.to_s) && \
                        @sop.file.content_type == "application/pdf"

      @content ||= ""

      @reader = PDF::Reader.new(@sop.file.path)
      @reader.pages.each do |page|
        @content.concat(page.text)
      end

      @content.force_encoding("UTF-8")
    end
end
