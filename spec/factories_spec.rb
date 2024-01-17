# frozen_string_literal: true

require 'rails_helper'

describe 'FactoryBot' do
  it 'creates valid objects' do
    expect { FactoryBot.lint }.not_to raise_error
  end
end
