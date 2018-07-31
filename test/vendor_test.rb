require './lib/vendor'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class VendorTest < MiniTest::Test
  def test_it_exists
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_instance_of Vendor, vendor
  end

  def test_it_has_a_name
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal "Rocky Mountain Fresh", vendor.name
  end

  def test_its_inventory_starts_empty
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal ({}), vendor.inventory
  end

  def test_that_it_can_add_to_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)

    assert_equal ({"Peaches" => 30}), vendor.inventory
  end

  def test_it_can_check_the_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)

    assert_equal 30, vendor.check_stock("Peaches")
  end

  def test_it_returns_0_if_item_is_not_in_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)

    assert_equal 0, vendor.check_stock("Apples")
  end

  def test_it_can_add_more_to_an_item
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)
    vendor.stock("Tomatoes", 12)
    assert_equal 30, vendor.check_stock("Peaches")

    vendor.stock("Peaches", 30)
    assert_equal 60, vendor.check_stock("Peaches")
  end
end
