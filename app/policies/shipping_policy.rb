class ShippingPolicy < Struct.new(:user, :shipping)

  def trico_labels?
    return true
  end

  def smalog_labels?
    return true
  end

end