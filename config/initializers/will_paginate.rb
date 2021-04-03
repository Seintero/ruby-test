# frozen_string_literal: true

def will_paginate(collection_or_options = nil, options = {})
  if collection_or_options.is_a? Hash
    options = collection_or_options
    collection_or_options = nil
  end
  options = options.merge renderer: WillPaginate::ActionView::BootstrapLinkRenderer unless options[:renderer]
  super(*[collection_or_options, options].compact)
end
