module Plays
  class RetrievalService
    include Rails.application.routes.url_helpers

    DEFAULT_ITEMS_LENGTH = 10

    attr_reader :length, :klass, :result

    def initialize(length: DEFAULT_ITEMS_LENGTH, klass: Image)
      @length = length
      @klass = klass
    end

    def perform
      raise NotImplementedError, "#{klass} does not allow to retrieve its objects." unless
        klass.respond_to?(:take)

      collection = transform_with_indices(base_collection)

      @result = if (col_len = collection.count) == length || collection.blank?
                  collection
                else
                  # Populate the array with the same elements until it reaches needed length
                  (collection * (length / col_len.to_f).ceil).take(length)
                end
    end

    private

    def base_collection
      @base_collection = klass.take(length)
                              .map { |item| { url: polymorphic_url(item.attachment), id: item.id } }
                              .shuffle
    end

    def transform_with_indices(collection)
      collection.each_with_object([]).with_index do |(el, memo), idx|
        memo << {
          index: idx,
          url: el[:url],
          id: el[:id]
        }
      end
    end
  end
end
