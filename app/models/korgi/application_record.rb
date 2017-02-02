# frozen_string_literal: true
module Korgi
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
