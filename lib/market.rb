class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def sorted_item_list
    vendor_items = @vendors.map do |vendor|
      vendor.inventory.keys
    end.flatten.uniq

    vendor_items.sort
  end

  def total_inventory
    vendor_items = @vendors.map do |vendor|
      vendor.inventory
    end

    merged = vendor_items.reduce(Hash.new) do |new_hash, old_hash|
      new_hash.merge(old_hash){|key, old_val, new_val| old_val + new_val}
    end
  end

  def sell(item, count)
    vendors_that_sell(item).reduce(count) do |new_count, vendor|
      new_count = new_count.abs
      new_count = vendor.inventory[item] - new_count
      if new_count < 0
        vendor.inventory[item] = 0
      else
        vendor.inventory[item] = new_count
      end
      new_count
    end

    even_possible?(item, count)
    binding.pry
  end

  def even_possible?(item, count)
    if total_inventory[item] > count
      true
    else
      false
    end
  end
end
