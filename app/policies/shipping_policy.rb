class ShippingPolicy < Struct.new(:user, :home)

  def trico_labels?
    return true
  end

end