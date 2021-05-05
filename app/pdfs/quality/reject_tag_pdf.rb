class Quality::RejectTagPdf < ::VarlandPdf

  SECTION_HEADER_HEIGHT = 0.35

  def initialize(reject_tag)
    super()
    @reject_tag = reject_tag
    self.print_data
  end

  def print_data

    # Generic options.
    self.line_width = 0.02.in
    header_options_center = { size: 8, style: :bold, h_align: :center, v_align: :center, fill_color: "cccccc", h_pad: 0.1 }
    header_options_left = { size: 8, style: :bold, h_align: :left, v_align: :center, fill_color: "cccccc", h_pad: 0.1 }
    data_options_center = { size: 10, style: :bold, h_align: :center, v_align: :center, h_pad: 0.1 }
    data_options_center_large = { size: 24, style: :bold, h_align: :center, v_align: :center, h_pad: 0.1 }
    data_options_center_medium = { size: 12, style: :bold, h_align: :center, v_align: :center, h_pad: 0.1 }
    data_options_left = { size: 10, h_align: :left, v_align: :top, h_pad: 0.1, v_pad: 0.1 }

    # Draw section header boxes.
    self.txtb("SECTION 1 – IDENTIFICATION & DESCRIPTION", 0.25, 10.75, 8, 0.35, fill_color: "000000", color: "ffffff", size: 10, style: :bold, h_align: :left, h_pad: 0.1)
    self.txtb("SECTION 2 – LOAD SPECIFIC INFORMATION", 0.25, 6.85, 8, 0.35, fill_color: "000000", color: "ffffff", size: 10, style: :bold, h_align: :left, h_pad: 0.1)
    self.txtb("SECTION 3 – CAUSE OF DEFECT/PROBLEM", 0.25, 5.5, 8, 0.35, fill_color: "000000", color: "ffffff", size: 10, style: :bold, h_align: :left, h_pad: 0.1)
    self.txtb("SECTION 4 – APPROVAL WITHOUT REWORK", 0.25, 1.65, 8, 0.35, fill_color: "000000", color: "ffffff", size: 10, style: :bold, h_align: :left, h_pad: 0.1)

    # Draw data header boxes.
    self.txtb("SHOP ORDER", 0.25, 10.4, 2, 0.25, header_options_center)
    self.txtb("REJECT TAG #", 2.25, 10.4, 2, 0.25, header_options_center)
    self.txtb("SOURCE", 4.25, 10.4, 2, 0.25, header_options_center)
    self.txtb("DATE", 6.25, 10.4, 2, 0.25, header_options_center)
    self.txtb("CUSTOMER CODE", 0.25, 9.65, 2, 0.25, header_options_center)
    self.txtb("PROCESS", 2.25, 9.65, 1, 0.25, header_options_center)
    self.txtb("PART ID", 3.25, 9.65, 4, 0.25, header_options_center)
    self.txtb("SUB ID", 7.25, 9.65, 1, 0.25, header_options_center)
    self.txtb("LOAD #", 0.25, 9.05, 1, 0.25, header_options_center)
    self.txtb("POUNDS", 1.25, 9.05, 1, 0.25, header_options_center)
    self.txtb("REJECTED BY", 2.25, 9.05, 2, 0.25, header_options_center)
    self.txtb("DEPARTMENT", 4.25, 9.05, 2, 0.25, header_options_center)
    self.txtb("DEFECT", 6.25, 9.05, 2, 0.25, header_options_center)
    self.txtb("DESCRIPTION OF PROBLEM/DEFECT", 0.25, 8.45, 8, 0.25, header_options_left)
    self.txtb("LOAD #", 0.25, 6.5, 1, 0.25, header_options_left)
    self.txtb("BARREL #", 0.25, 6.25, 1, 0.25, header_options_left)
    self.txtb("STATION #", 0.25, 6, 1, 0.25, header_options_left)
    self.txtb("COMMENTS", 2.25, 5.15, 6, 0.25, header_options_left)
    y = 5.15
    Quality::RejectTag.cause_options.each do |cause|
      self.txtb(cause.upcase, 0.25, y, 1.5, 0.25, header_options_left)
      y -= 0.25
    end
    self.txtb("LOADS APPROVED", 0.25, 1.3, 1.25, 0.25, header_options_left)
    self.txtb("APPROVED BY", 4.5, 1.3, 1.25, 0.25, header_options_left)
    self.txtb("COMMENTS", 0.25, 1.05, 1.25, 0.8, header_options_left)

    # Draw data boxes.
    self.txtb(@reject_tag.shop_order.number, 0.25, 10.15, 2, 0.5, data_options_center_large)
    self.txtb(@reject_tag.number, 2.25, 10.15, 2, 0.5, data_options_center_large)
    self.txtb(@reject_tag.source_description, 4.25, 10.15, 2, 0.5, data_options_center_medium)
    self.txtb(@reject_tag.rejected_on.strftime("%m/%d/%y"), 6.25, 10.15, 2, 0.5, data_options_center_medium)
    self.txtb(@reject_tag.shop_order.customer_code, 0.25, 9.4, 2, 0.35, data_options_center)
    self.txtb(@reject_tag.shop_order.process_code, 2.25, 9.4, 1, 0.35, data_options_center)
    self.txtb(@reject_tag.shop_order.part, 3.25, 9.4, 4, 0.35, data_options_center)
    self.txtb(@reject_tag.shop_order.sub, 7.25, 9.4, 1, 0.35, data_options_center)
    self.txtb(@reject_tag.loads_rejected, 0.25, 8.8, 1, 0.35, data_options_center)
    self.txtb(self.format_number(@reject_tag.pounds, decimals: 2, strip_insignificant_zeros: true), 1.25, 8.8, 1, 0.35, data_options_center)
    self.txtb(@reject_tag.user.name, 2.25, 8.8, 2, 0.35, data_options_center)
    self.txtb(helpers.department_name(@reject_tag.department, prefix: false), 4.25, 8.8, 2, 0.35, data_options_center)
    self.txtb(@reject_tag.defect, 6.25, 8.8, 2, 0.35, data_options_center)
    self.txtb(@reject_tag.defect_description, 0.25, 8.2, 8, 1.1, data_options_left)
    if @reject_tag.loads.length > 14
      self.txtb("Too Many Loads to Print".upcase, 1.25, 6.5, 7, 0.75, data_options_center_large)
    else
      x = 1.25
      @reject_tag.loads.each do |load|
        self.txtb(load.number, x, 6.5, 0.5, 0.25, data_options_center)
        self.txtb(load.barrel, x, 6.25, 0.5, 0.25, data_options_center)
        self.txtb(load.station, x, 6, 0.5, 0.25, data_options_center)
        x += 0.5
      end
    end
    cause_index = Quality::RejectTag.cause_options.index(@reject_tag.cause)
    self.txtb("×", 1.75, 5.15 - 0.25 * cause_index, 0.5, 0.25, data_options_center_large)
    self.txtb(@reject_tag.cause_description, 2.25, 4.9, 6, 3, data_options_left)

    # Draw horiztonal lines.
    hlines = [10.75, 10.4, 10.15, 9.65, 9.4, 9.05, 8.8, 8.45, 8.2, 7.1, 6.85, 6.5, 5.75, 5.5, 5.15, 4.9, 1.9, 1.65, 1.3, 1.05, 0.25]
    if @reject_tag.loads.length > 14
      self.hline(0.25, 6.25, 1)
      self.hline(0.25, 6, 1)
    else
      hlines << 6.25
      hlines << 6
    end
    hlines.each do |y|
      self.hline(0.25, y, 8, print: false)
    end
    hlines = [4.65, 4.4, 4.15, 3.9, 3.65, 3.4, 3.15, 2.9, 2.65, 2.4, 2.15]
    hlines.each do |y|
      self.hline(0.25, y, 2, print: false)
    end

    # Draw vertical lines.
    self.vline(0.25, 10.75, 3.65, print: false)
    self.vline(8.25, 10.75, 3.65, print: false)
    [2.25, 4.25, 6.25].each do |x|
      self.vline(x, 10.4, 0.75, print: false)
    end
    [2.25, 3.25, 7.25].each do |x|
      self.vline(x, 9.65, 0.6, print: false)
    end
    [1.25, 2.25, 4.25, 6.25].each do |x|
      self.vline(x, 9.05, 0.6, print: false)
    end
    self.vline(0.25, 6.85, 1.1, print: false)
    self.vline(1.25, 6.5, 0.75, print: false)
    self.vline(8.25, 6.85, 1.1, print: false)
    unless @reject_tag.loads.length > 14
      x = 1.75
      13.times do
        self.vline(x, 6.5, 0.75, print: false)
        x += 0.5
      end
    end
    self.vline(0.25, 5.5, 3.6, print: false)
    self.vline(1.75, 5.15, 3.25, print: false)
    self.vline(2.25, 5.15, 3.25, print: false)
    self.vline(8.25, 5.5, 3.6, print: false)
    self.vline(0.25, 1.65, 1.4, print: false)
    self.vline(8.25, 1.65, 1.4, print: false)
    self.vline(1.5, 1.3, 1.05, print: false)
    self.vline(4.5, 1.3, 0.25, print: false)
    self.vline(5.75, 1.3, 0.25, print: false)

    # Add attachments.
    max_image_width = 8
    max_image_height = 8.65
    count_images = 0
    @reject_tag.attachments.each do |attachment|
      next unless attachment.file.content_type.include? "image"
      count_images += 1
    end
    if count_images > 0
      image_index = 0
      @reject_tag.attachments.each do |attachment|
        next unless attachment.file.content_type.include? "image"
        this_image_height = max_image_height
        self.start_new_page
        self.txtb(@reject_tag.description, 0.25, 10.75, 8, 0.35, fill_color: "000000", color: "ffffff", size: 10, style: :bold, h_align: :left, h_pad: 0.1)
        self.txtb("Attachment #{image_index + 1} of #{count_images}", 0.25, 10.75, 8, 0.35, color: "ffffff", size: 10, style: :bold, h_align: :right, h_pad: 0.1)
        self.txtb(attachment.name, 0.5, attachment.description.blank? ? 0.5 : 1.25, 7.5, 0.25, size: 14, h_align: :center)
        if attachment.description.blank?
          this_image_height += 0.75
        else
          self.txtb(attachment.description, 0.5, 1, 7.5, 0.75, style: :italic, size: 10, h_align: :center, v_align: :top)
        end
        image = self.get_image(attachment.file, max_image_width, this_image_height)
        self.bounding_box([(0.25 + ((max_image_width - image[:width]) / 2.0)).in, (10.15 - ((this_image_height - image[:height]) / 2.0)).in], width: image[:width].in, height: image[:height].in) do
          self.image(image[:path], fit: [image[:width].in, image[:height].in])
        end
        image_index += 1
      end
    end

  end

end