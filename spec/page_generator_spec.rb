require 'spec_helper'
require 'page_generator'

describe PageGenerator do
  let :app do
    middleman_app("test_app")
  end

  subject do
    app.activate :page_generator
  end

  it 'should create app' do
    pp app.class
  end

  it 'should create subject' do
    pp app.class
    pp subject
  end
end
