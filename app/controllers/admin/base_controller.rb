# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  layout 'application'

  before_action :authenticate_admin!
end
