require "helper"
require "fluent/plugin/filter_unwinddata.rb"

class UnwinddataFilterTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Filter.new(Fluent::Plugin::UnwinddataFilter).configure(conf)
  end
end
