class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  #allow all controllers to have access to the sessions helper
  include SessionsHelper
end
