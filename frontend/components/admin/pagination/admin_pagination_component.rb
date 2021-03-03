module AdminPaginationComponent
  extend ComponentHelper

  property :items, required: true
  property :paginate_params, default: {}
end
