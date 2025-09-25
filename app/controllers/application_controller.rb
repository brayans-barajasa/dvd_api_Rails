class ApplicationController < ActionController::API
  include Paginatable
  include ExceptionHandler
  include JsonRenderable
  include Searchable
end
