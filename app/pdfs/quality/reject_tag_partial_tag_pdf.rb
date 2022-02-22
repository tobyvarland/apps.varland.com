class Quality::RejectTagPartialTagPdf < ::VarlandPdf

  DEFAULT_FONT_FAMILY = "Arial Narrow"
  DEFAULT_FONT_STYLE = :bold

  def initialize(shop_order)
    super()
    @shop_order = shop_order
    self.print_data
  end

  def print_data

    # Draw shop order numbers.
    self.txtb(@shop_order.number, 0.5, 10.75, 3, 0.6, size: 40, h_align: :left, v_align: :top)
    self.txtb(@shop_order.number, 8.25, 10.75, 2.3, 0.6, size: 40, h_align: :center, rotate: 270, v_align: :top)

    # Draw partial tag.
    self.txtb("PARTIAL ORDER", 2.25, 10.75, 3, 0.4, size: 40, fill_color: "ffff00")

    # Create shop order barcode.
    barcode = Barby::Code39.new @shop_order.number.to_s.rjust(10)
    barcode.annotate_pdf self, x: 5.58.in, y: 10.45.in, width: 2.5.in, height: 0.3.in

    # Draw text under barcode.
    self.txtb("VMS#{@shop_order.number}", 5.58, 10.45, 2.5, 0.2, h_align: :left, size: 11)
    self.txtb(@shop_order.received_at.strftime("%m/%d/%y %H:%M"), 5.58, 10.45, 2.17, 0.2, h_align: :right, size: 11)

    # Draw shaded background if necessary.
    @color = nil
    case @shop_order.schedule_code
    when "YEL"
      @color = "f9d423"
    when "GRN"
      @color = "93dfb8"
    end
    unless @color.blank?
      self.rect(0.25, 10.25, 7.5, 1.5, fill_color: @color, line_color: nil)
      self.rect(0.25, 8.45, 4.05, 2, fill_color: @color, line_color: nil)
      self.rect(4.3, 8.45, 3.95, 0.8, fill_color: @color, line_color: nil)
    end

    # Draw header boxes.
    self.txtb("CUSTOMER NAME", 0.25, 10.25, 3.5, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("CUST CODE", 3.75, 10.25, 1, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("PROC CODE", 4.75, 10.25, 0.7, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("PART ID", 5.45, 10.25, 2, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("SUB", 7.45, 10.25, 0.3, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("EQUIPMENT USED", 0.25, 9.75, 3.5, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("PART NAME & INFORMATION", 3.75, 9.75, 2.5, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("CUSTOMER PO #", 6.25, 9.75, 1.5, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("SHOP ORDER DATE", 0.25, 8.95, 1.25, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("POUNDS", 1.5, 8.95, 1.4, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("PIECES", 2.9, 8.95, 1.4, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("CONTAINERS", 4.3, 8.95, 2.15, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("SHIPPING #", 6.45, 8.95, 1.3, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("PROCESS SPECIFICATION", 0.25, 8.45, 4.05, 0.2, size: 9, fill_color: "cccccc")
    self.txtb("PART & MATERIAL DESCRIPTION", 4.3, 8.45, 3.95, 0.2, size: 9, fill_color: "cccccc")

    # Draw data boxes.
    self.txtb(@shop_order.customer_name[0], 0.25, 10.05, 3.5, 0.3, size: 14, h_align: :left, h_pad: 0.05)
    self.txtb(@shop_order.customer_code, 3.75, 10.05, 1, 0.3, size: 14, h_pad: 0.05)
    self.txtb(@shop_order.process_code, 4.75, 10.05, 0.7, 0.3, size: 14, h_pad: 0.05)
    self.txtb(@shop_order.part, 5.45, 10.05, 2, 0.3, size: 14, h_align: :left, h_pad: 0.05)
    self.txtb(@shop_order.sub, 7.45, 10.05, 0.3, 0.3, size: 14, h_pad: 0.05)
    0.upto(2) {|i|
      self.txtb(@shop_order.equipment_used[i], 0.25, 9.55 - 0.2 * i, 3.5, 0.2, size: 11, h_align: :left, h_pad: 0.05)
      self.txtb(@shop_order.part_name[i], 3.75, 9.55 - 0.2 * i, 2.5, 0.2, size: 11, h_align: :left, h_pad: 0.05)
      self.txtb(@shop_order.purchase_order[i], 6.25, 9.55 - 0.2 * i, 1.5, 0.2, size: 11, h_align: :left, h_pad: 0.05)
      self.txtb(@shop_order.part_description[i], 4.3, 8.25 - 0.2 * i, 3.95, 0.2, size: 11, h_align: :left, h_pad: 0.05)
    }
    self.txtb(@shop_order.received_on.strftime("%m/%d/%y"), 0.25, 8.75, 1.25, 0.3, size: 14, h_pad: 0.05)
    self.txtb(self.format_number(@shop_order.pounds, decimals: 2, delimiter: ","), 1.5, 8.75, 1.4, 0.3, size: 14, h_pad: 0.05)
    self.txtb(self.format_number(@shop_order.pieces, delimiter: ","), 2.9, 8.75, 1.4, 0.3, size: 14, h_pad: 0.05)
    self.txtb(self.helpers.pluralize(@shop_order.container_count, @shop_order.container_type).upcase, 4.3, 8.75, 2.15, 0.3, size: 14, h_align: :left, h_pad: 0.05)
    0.upto(8) {|i|
      self.txtb(@shop_order.process_spec[i], 0.25, 8.25 - 0.2 * i, 4.05, 0.2, size: 11, h_align: :left, h_pad: 0.05)
    }

    # Draw horizontal lines.
    [10.25, 10.05, 9.75, 9.55, 8.95, 8.75].each do |y|
      self.hline(0.25, y, 7.5)
    end
    [8.45, 8.25].each do |y|
      self.hline(0.25, y, 8)
    end
    self.hline(0.25, 6.45, 4.05)
    self.hline(4.3, 7.65, 3.95)

    # Draw vertical lines.
    self.vline(0.25, 10.25, 3.8)
    self.vline(7.75, 10.25, 1.8)
    self.vline(3.75, 10.25, 1.3)
    self.vline(4.75, 10.25, 0.5)
    self.vline(5.45, 10.25, 0.5)
    self.vline(7.45, 10.25, 0.5)
    self.vline(6.25, 9.75, 0.8)
    [1.5, 2.9, 4.3, 6.45].each do |x|
      self.vline(x, 8.95, 0.5)
    end
    self.vline(4.3, 8.45, 2)
    self.vline(8.25, 8.45, 0.8)

    # Draw description.
    self.txtb("THIS TAG WAS PRINTED DUE TO A REJECT TAG BEING CREATED. KEEP IT WITH NON-REJECTED PARTS.", 0.25, 6.2, 8, 0.25, size: 14, color: "ff0000")

    # Draw approval boxes.
    self.txtb("INSPECTED & APPROVED LOADS", 0.25, 5.7, 4.05, 0.3, fill_color: "cccccc", size: 14)
    self.txtb("DATE", 0.25, 5.4, 1, 0.2, fill_color: "cccccc", size: 9)
    self.txtb("LOAD #", 1.25, 5.4, 2, 0.2, fill_color: "cccccc", size: 9)
    self.txtb("EMP", 3.25, 5.4, 1.05, 0.2, fill_color: "cccccc", size: 9)

    # Horizontal lines for approval boxes.
    [5.7, 5.4, 5.2].each do |y|
      self.hline(0.25, y, 4.05)
    end
    y = 5.2
    while y > 0
      y -= 0.45
      self.hline(0.25, y, 4.05)
    end

    # Vertical lines for approval boxes.
    self.vline(0.25, 5.7, 5.45)
    self.vline(4.3, 5.7, 5.45)
    self.vline(1.25, 5.4, 5.15)
    self.vline(3.25, 5.4, 5.15)

  end

end