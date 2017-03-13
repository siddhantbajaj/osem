prawn_document(filename: @pdf_filename, page_layout: :landscape) do |pdf|
 pdf.image "/home/siddhant/Desktop/osem-logo.png", :at => [0, pdf.cursor]
 pdf.text "#{@conference.title}", :align => :right
 pdf.text "#{@conference.venue.name},#{@conference.venue.street},#{@conference.venue.city} / #{@conference.venue.country_name}", :align => :right
 pdf.move_down 100
 pdf.text "Registration Ticket", :align => :center
 pdf.move_down 30
 pdf.draw_text "Registration Date: ", :at => [0, pdf.cursor]
 pdf.draw_text "Registration ID: ", :at => [pdf.bounds.right - 200, pdf.cursor]
 pdf.pad(20){pdf.stroke_horizontal_rule}
 pdf.draw_text "Name: ", :at => [0, pdf.cursor]
 pdf.draw_text "Email: ", :at => [pdf.bounds.right - 200, pdf.cursor]
 pdf.move_down 20
 pdf.draw_text "Username: ", :at => [0, pdf.cursor]
 pdf.draw_text "Contact: ", :at => [pdf.bounds.right - 200, pdf.cursor]
 pdf.pad(20){pdf.stroke_horizontal_rule}
 pdf.draw_text "Type: ", :at => [0, pdf.cursor]
 pdf.draw_text "Amount: ", :at => [pdf.bounds.right - 200, pdf.cursor]
 pdf.move_down 20
 pdf.draw_text "Arrival: ", :at => [0, pdf.cursor]
 pdf.draw_text "Departure: ", :at => [pdf.bounds.right - 200, pdf.cursor]
 pdf.pad(20){pdf.stroke_horizontal_rule}
 pdf.print_qr_code(@user.username, :extent=>72)
end
